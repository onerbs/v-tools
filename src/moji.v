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
	args := plu.need_args(1) or { return }
	if args == ['-l'] {
		for key, value in moji.data {
			emoji := string(value)
			println('$emoji\t$key')
		}
		return
	}
	lines := plu.get_lines(args)
	for line in lines {
		println(moji.parse(line))
	}
}
