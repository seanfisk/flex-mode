FLEX_SRC_DIR := flex-2.5.37
FLEX_BUILD_DIR := $(FLEX_SRC_DIR)-build
FLEX_CONFIG_H := $(FLEX_BUILD_DIR)/config.h

# Don't depend on the flex files because we don't expect them to
# change.
get_options: get_options.c "$(FLEX_CONFIG_H)"
	$(CC) -o $@ -DHAVE_CONFIG_H "-I$(FLEX_BUILD_DIR)" "-I$(FLEX_SRC_DIR)" $^ $(foreach src_file,options.c scanopt.c,"$(FLEX_SRC_DIR)/$(src_file)")

# Unfortunately, this will always run, since `config.h' is recreated
# with a new timestamp with every re-configure.
"$(FLEX_CONFIG_H)":
# -p prevents mkdir from complaining if the directory already
# exists.
	mkdir -p "$(FLEX_BUILD_DIR)"
	cd "$(FLEX_BUILD_DIR)"; "../$(FLEX_SRC_DIR)/configure"

.PHONY: clean
clean:
	$(RM) -r get_options "$(FLEX_BUILD_DIR)"
