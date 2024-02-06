LIB_DIR = $(ARTIFACTS_DIR)/lib
LIB_FILES = \
  /usr/lib64/libpq.so.*

build-PGLayer:
	@yum install -y postgresql-devel
	@mkdir -p $(LIB_DIR)
	@for f in $(LIB_FILES); do cp $$f $(LIB_DIR); done