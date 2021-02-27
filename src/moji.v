module main

import plu
import moji

//
// Usage: moji [<options>] [<input>]
//
// Options:
//   -l    Print the emoji list and exit
//   -     Read <input> from the standard input
//
// Examples:
//   moji :sparkles:
//   git log --oneline | moji -
//

fn main() {
	args := plu.get_args()
	if args.len == 0 {
		return
	}
	if args == ['-l'] {
		for key, value in moji.data {
			println('$value\t$key')
		}
		return
	}
	lines := plu.get_lines(args)
	for line in lines {
		println(moji.parse(line))
	}
}
