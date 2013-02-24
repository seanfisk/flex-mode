FLEX_SRC_DIR := flex-2.5.37

# Don't depend on the flex files because we don't expect them to
# change.
get_options: get_options.c
	$(CC) -o $@ -DHAVE_CONFIG_H "-I$(FLEX_SRC_DIR)" $^ $(foreach src_file,options.c scanopt.c,"$(FLEX_SRC_DIR)/$(src_file)")

.PHONY: clean
clean:
	$(RM) get_options
