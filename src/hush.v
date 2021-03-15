module main

import os
import plu { fail }
import strings
import hush

// Hash files or text

//
// Usage: hush [<options>] <input>
//
// Options:
//   -a <algorithm>    Specify the algorithm to be used (*)
//   -f                Enable the file mode
//   -                 Read <input> from the standard input
//
// Algorithms:
//   md5
//   sha1
//
//   * If no algorithm is specified, MD5 will be used by default
//
// Examples:
//   hush -a sha1 hello
//   hush -f somefile.txt otherfile.txt
//   echo hello | hush -
//   find -type f | hush -a sha1 -f -
//

fn main() {
	mut args := plu.need_args(1) or { exit(fail(err.msg)) }

	algorithm := plu.parse_flag_value(mut args, ['-a'], 'md5')
	file_mode := plu.parse_flag(mut args, ['-f'])
	from_stdin := args == ['-']

	mut items := []string{}
	if from_stdin && file_mode {
		lines := os.get_lines()
		if lines.len == 1 {
			items << lines[0].split(' ')
		} else {
			items << lines
		}
	} else if from_stdin {
		items = os.get_lines()
	} else if file_mode {
		items << args
	} else {
		items = [args.join(' ')]
	}

	husher := hush.get_husher(algorithm)

	if file_mode {
		println(plu.table(hash_files(husher, items), '\n', ';'))
	} else {
		println(items.map(husher.hash(it)).join('\n'))
	}
}

fn hash_files(h hush.Husher, items []string) string {
	if items.len == 0 {
		exit(0)
	}
	mut b := strings.new_builder(items.len * 32)
	for item in items {
		if os.is_dir(item) {
			fail('"$item" is a directory')
			continue
		}
		bs := os.read_bytes(item) or { exit(fail(err.msg)) }
		hash := h.hash_bytes(bs)
		b.writeln('$item:;$hash')
	}
	b.go_back(1)
	return '$b'
}
