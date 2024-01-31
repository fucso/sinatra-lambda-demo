FROM public.ecr.aws/sam/build-ruby3.2

WORKDIR /usr/src/app

RUN yum update -y \
    && yum install -y amazon-linux-extras \
    && amazon-linux-extras enable postgresql13 \
    && yum group install "Development Tools" -y
RUN yum install -y postgresql postgresql-devel

# Install Bundler for Ruby
RUN gem install bundler