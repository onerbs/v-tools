module main

import plu

// Usage: nth <position> [<options>] [<input>]

// Options:
//   -d <delimiter>    Use <delimiter> to determine the parts
//   -                 Read <input> from the standard input

// Examples:
//   nth  3 a b c d e    >> c
//   nth -2 a b c d e    >> d

const space = ':space:'

fn naim() ? {
	mut args := plu.need_args(1) ?

	delimiter := plu.parse_flag_value(mut args, ['-d'], space)
	index := get_index(mut args) ?

	lines := plu.get_lines_from(args)

	for line in lines {
		items := get_items(line, delimiter)
		if index < 0 {
			if index < -items.len {
				return error(min_bound(index, -items.len))
			}
			println(items[items.len + index])
		} else {
			if index >= items.len {
				position := index + 1
				return error(max_bound(position, items.len))
			}
			println(items[index])
		}
	}
}

fn get_items(line string, delimiter string) []string {
	mut parts := []string{}
	if delimiter == space {
		mut word := []byte{}
		for c in line {
			if c.is_space() {
				if word.len > 0 {
					parts << string(word)
					word = []byte{}
				}
			} else {
				$if debug {
					println('$c\t${rune(c)}')
				}
				word << c
			}
		}
		if word.len > 0 {
			parts << string(word)
			word = []byte{}
		}
	} else {
		parts << line.split(delimiter)
	}
	return parts
}

fn get_index(mut args []string) ?int {
	raw := args[0]
	args.delete(0)

	mut position := raw.int()
	if position == 0 {
		return error(bad_position(raw))
	}
	return if position > 0 { position - 1 } else { position }
}

fn min_bound(index int, limit int) string {
	return bad_bound('min', index, limit)
}

fn max_bound(position int, limit int) string {
	return bad_bound('max', position, limit)
}

fn bad_bound(bound string, position int, limit int) string {
	return position_err('$position', '${bound}imum is $limit')
}

fn bad_position(position string) string {
	return position_err(position, 'expecting a number different from 0')
}

fn position_err(position string, msg string) string {
	return 'bad position "$position", $msg'
}

fn main() {
	naim() or { exit(plu.fail(err)) }
}
