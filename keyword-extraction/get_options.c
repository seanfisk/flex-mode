#include "options.h"

#include <stdio.h>

int main(int argc, char *argv[]) {
	unsigned opts_index = 0;
	while(true) {
		// Grab the option format. Cast off `const'. Don't do this in a
		// real program.
		char *opt_fmt = (char *)flexopts[opts_index].opt_fmt;
		if(opt_fmt == 0) {
			// Exit if we are at the end of the list.
			break;
		}

		// Trim off leading hyphens.
		while(true) {
			switch(*opt_fmt) {
			case '\0':
			case '-':
				opt_fmt++;
				continue;
			}
			break;
		}

		// Go up until the end of the string, a ` ', '`=', or `['.
		while(true) {
			switch(*opt_fmt) {
			case '\0':
			case ' ':
			case '=':
			case '[':
				goto back_trim_end;
			}
			putchar(*opt_fmt);
			++opt_fmt;
		}
	back_trim_end:
		putchar('\n');

		++opts_index;
	}
	return 0;
}
