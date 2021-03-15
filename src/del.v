module main

import os
import plu { fail }

//
// Usage: del [<options>] <input>
//
// Options:
//   -r    Remove a directory recursively
//   -     Read <input> from the standard input
//         Threat each line as a file, (may contain spaces)
//

fn main() {
	mut args := plu.get_args()
	rec := plu.parse_flag(mut args, ['-r'])

	for item in plu.get_input_from(args) {
		del := if os.is_dir(item) {
			if rec {
				os.rmdir_all
			} else {
				os.rmdir
			}
		} else {
			os.rm
		}
		del(item) or { exit(fail(err.msg)) }
	}
}
