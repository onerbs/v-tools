module main

import rs
import xsh
import cmd
import rand

// Create random strings

/*
Usage: rs <options>

Options:
  -s <size>  Set the size of the generated string

  -u         Generate the string in uppercase
  -l         Generate the string in lowercase
           * By default generate in mixed case

  -a         Use the alpha character set
  -c         Use the ASCII character set
  -d         Use the numeric character set
  -x         Use the hexadecimal character set
           * By default generate an alphanumeric string
*/

fn main() {
	mut args := xsh.get_args()
	size := cmd.parse_flag_value(mut args, ['-s'], '16').int()
	chars := rs.get_ctx(args).get_charset()
	println(rand.string_from_set(chars, size))
}

fn fatal(err string) int {
	return xsh.fail('rs: $err')
}
