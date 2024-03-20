#!/bin/bash

# 引数が足りない場合は使い方を表示して終了
if [ "$#" -lt 6 ]; then
  echo "Usage: $0 --s3-bucket BUCKET_NAME --stack STACK_NAME"
  exit 1
fi

WITH_LAYER=false

# 引数を解析
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --s3-bucket)
      S3_BUCKET=$2
      shift 2
      ;;
    --stack)
      STACK=$2
      shift 2
      ;;
    --profile)
      PROFILE=$2
      shift 2
      ;;
    --with-layer)
      WITH_LAYER=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# 必要な変数が設定されているかチェック
if [ -z "$S3_BUCKET" ] || [ -z "$STACK" ] || [ -z "$PROFILE" ]; then
  echo "Error: Arguments --s3-bucket, --stack and --profile are required."
  exit 1
fi

# 入力ファイルと出力ファイル
template="template.yaml"
output_template="serverless-output.yaml"
deploy_template="template-deploy.yaml"

# 最新バージョンを取得
s3_layer_path="layers/pg"
layer_version=$(aws s3api list-objects-v2 --bucket "${S3_BUCKET}" --prefix "layers/pg/" --query 'Contents | sort_by(@, &LastModified)[-1].Key' --output text --profile ${PROFILE} | grep -o -E 'v([0-9]+)\.zip' | sed -E 's/v([0-9]+)\.zip/\1/')
if [ -z "${layer_version}" ]; then
  if [ "$WITH_LAYER" = false ]; then
    echo "Error: Layer not found. Run with --with-layer option."
    exit 1
  fi
  echo "Layer not found. Creating a new layer..."
  layer_version=0
fi

if [ "$WITH_LAYER" = true ]; then
  layer_version=$((layer_version + 1))
fi

s3_layer_path="${s3_layer_path}/v${layer_version}.zip"

if [ "$WITH_LAYER" = true ]; then
  echo "Packaging and uploading the layer..."

  bin/build.sh

  pushd .aws-sam/build/PGLayer
  zip -r ../PGLayer.zip *
  popd
  
  # ZIPファイルをS3にアップロード
  aws s3 cp .aws-sam/build/PGLayer.zip s3://${S3_BUCKET}/${s3_layer_path} --profile ${PROFILE}
fi

sam package \
  --template-file ${template} \
  --output-template-file ${output_template} \
  --s3-bucket ${S3_BUCKET} \
  --profile ${PROFILE}

# `PGLayerContentUri: !Ref PGLayerContentUri` を検索し、
# 指定されたバケットとキーで置き換える
indent="        "
sed "s|${indent}Ref: PGLayerContentUri|${indent}Bucket:\n${indent}  Ref: PGLayerS3Bucket\n${indent}Key:\n${indent}  Ref: PGLayerS3Key|" $output_template > $deploy_template

source .env
overrides=overrides="PGLayerS3Bucket=\"${S3_BUCKET}\" PGLayerS3Key=\"${s3_layer_path}\" EnvDbHost=\"${DB_HOST}\" EnvDbUser=\"${DB_USER}\" EnvDbPassword=\"${DB_PASSWORD}\" EnvDbName=\"${DB_NAME}\""

sam deploy \
  --template-file ${deploy_template} \
  --stack-name ${STACK} \
  --capabilities CAPABILITY_IAM \
  --parameter-overrides ${overrides}  \
  --profile ${PROFILE}