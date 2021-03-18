module main

import plu
import moji

//
// Usage: moji [<options>] [<input>]
//
// Options:
//   -f <name>    Find an emoji by name
//   -l           Print the emoji list and exit
//   -            Read <input> from the standard input
//
// Examples:
//   moji -f heart
//   moji :sparkles:
//   git log --oneline | moji -
//

fn main() {
	mut args := plu.need_args(1) or { return }

	find := plu.parse_flag(mut args, ['-f'])
	list := plu.parse_flag(mut args, ['-l'])

	if list {
		get_emoji('')
	} else if find {
		for key in args {
			get_emoji(key)
		}
	} else {
		lines := plu.get_lines_from(args)
		for line in lines {
			println(moji.parse(line))
		}
	}
}

fn get_emoji(key string) {
	for name, value in moji.data {
		if key in name {
			emoji := string(value)
			if key.len > 0 {
				found := name.replace_once(key, '\e[1;35m$key\e[m')
				println('$emoji\t$found')
			} else {
				println('$emoji\t$name')
			}
		}
	}
}
