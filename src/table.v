module main

import plu { fail }

// Usage: table [<options>] <input>

// Options:
//   -r <delimiter>    Define the row delimiter
//   -c <delimiter>    Define the cell delimiter
//   -                 Read <input> from the standard input

// Examples:
//   table -r _ a:b:c_:d:e
//   table -r : -c / - <<< $PATH
//   cat /etc/passwd | table -

fn main() {
	mut args := plu.need_args(1) or { exit(fail(err.msg)) }

	rd := plu.parse_flag_value(mut args, ['-r'], '\n')
	cd := plu.parse_flag_value(mut args, ['-c'], ':')

	src := plu.get_lines_from(args).join(rd)
	println(plu.table(src, rd, cd))
}
