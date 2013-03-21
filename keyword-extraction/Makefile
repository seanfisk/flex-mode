FLEX_SRC_DIR := flex-2.5.37
FLEX_CONFIG_H := "$(FLEX_SRC_DIR)/config.h"

# Don't depend on the flex files because we don't expect them to
# change.
get_options: get_options.c "$(FLEX_CONFIG_H)"
	$(CC) -o $@ -DHAVE_CONFIG_H "-I$(FLEX_SRC_DIR)" $^ $(foreach src_file,options.c scanopt.c,"$(FLEX_SRC_DIR)/$(src_file)")

# Unfortunately, this will always run, since `config.h' is recreated
# with a new timestamp with every re-configure.
"$(FLEX_CONFIG_H)":
	cd "$(FLEX_SRC_DIR)"; ./configure

.PHONY: clean
clean:
	$(RM) get_options
