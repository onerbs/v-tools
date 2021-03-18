module main

import os
import plu

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

	quiet := plu.parse_flag(mut args, ['-q'])
	recursive := plu.parse_flag(mut args, ['-r'])

	for item in plu.get_input_from(args) {
		file := plu.abs_path(item)
		is_dir := os.is_dir(file)
		is_link := os.is_link(file)
		del_fn := if is_dir && recursive {
			os.rmdir_all
		} else if is_dir {
			os.rmdir
		} else {
			os.rm
		}
		if !quiet {
			println(erase(
				file: file
				is_dir: is_dir
				is_link: is_link
				recursive: recursive
				del_fn: del_fn
			))
		}
	}
}

type DelFn = fn (string) ?

struct Del {
	file      string
	is_dir    bool
	is_link   bool
	recursive bool
	del_fn    DelFn
}

fn erase(del Del) string {
	mut result := ''
	mut status := true
	mut detail := ''

	del.del_fn(del.file) or {
		status = false
		detail = err.msg
	}

	if status {
		result += green(del.file)
	} else {
		result += red(del.file)
	}

	if del.is_dir {
		result += info('folder')
		if del.recursive {
			result += info('recursive')
		}
	} else {
		result += info('file')
	}
	if del.is_link {
		result += info('symlink')
	}
	if detail.len > 0 {
		result += report(detail)
	}
	return result
}

fn info(s string) string {
	return color(' ($s)', '2')
}

fn report(s string) string {
	return color(' [$s]', '2')
}

fn green(s string) string {
	return color(s, '1;32')
}

fn red(s string) string {
	return color(s, '1;31')
}

fn color(s string, m string) string {
	return '\e[${m}m$s\e[m'
}
