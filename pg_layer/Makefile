LIB_DIR = $(ARTIFACTS_DIR)/lib
LIB_FILES = \
  /usr/lib64/libpq.so.5 \
	/usr/lib64/libldap_r-2.4.so.2 \
	/usr/lib64/liblber-2.4.so.2 \
	/usr/lib64/libsasl2.so.3 \
	/usr/lib64/libssl3.so \
	/usr/lib64/libsmime3.so \
	/usr/lib64/libnss3.so \
	/usr/lib64/libnssutil3.so

build-PGLayer:
	@mkdir -p $(LIB_DIR)
	@for f in $(LIB_FILES); do cp $$f $(LIB_DIR); done