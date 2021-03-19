module rs

enum CharCase {
	upper
	lower
	mixed
}

enum CharSet {
	custom
	alnum
	alpha
	ascii
	digit
	hex
}

struct Context {
	charcase CharCase
	charset  CharSet
	custom   string
}

pub fn get_ctx(args []string) Context {
	mut charcase := CharCase.mixed
	mut charset := CharSet.alnum
	mut custom := ''

	for s in args {
		if s[0] != `-` {
			custom = s
			charset = .custom
			continue
		}

		for c in s[1..] {
			match c {
				`u` { charcase = .upper }
				`l` { charcase = .lower }
				`a` { charset = .alpha }
				`c` { charset = .ascii }
				`d` { charset = .digit }
				`x` { charset = .hex }
				else {}
			}
		}
	}
	return Context{charcase, charset, custom}
}

const (
	set_digit       = '0123456789'
	set_upper       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	set_lower       = 'abcdefghijklmnopqrstuvwxyz'
	set_symbl       = '!"#$%&\'()*+,-./:;<=>?@\\^_`{|}~'
	set_mixed       = set_upper + set_lower
	set_upper_alnum = set_upper + set_digit
	set_lower_alnum = set_lower + set_digit
	set_mixed_alnum = set_upper + set_digit + set_lower
	set_upper_ascii = set_upper_alnum + set_symbl
	set_lower_ascii = set_lower_alnum + set_symbl
	set_mixed_ascii = set_mixed_alnum + set_symbl
	set_upper_hex   = 'ABCDEF0123456789'
	set_lower_hex   = 'abcdef0123456789'
	set_mixed_hex   = 'ABCDEF0123456789abcdef'
)

pub fn (ctx Context) get_chars() string {
	if ctx.charset == .custom {
		return ctx.custom
	}
	if ctx.charset == .digit {
		return rs.set_digit
	}
	mut chars := ''
	match ctx.charcase {
		.upper {
			chars = match ctx.charset {
				.alpha { rs.set_upper }
				.alnum { rs.set_upper_alnum }
				.ascii { rs.set_upper_ascii }
				.hex { rs.set_upper_hex }
				else { chars }
			}
		}
		.lower {
			chars = match ctx.charset {
				.alpha { rs.set_lower }
				.alnum { rs.set_lower_alnum }
				.ascii { rs.set_lower_ascii }
				.hex { rs.set_lower_hex }
				else { chars }
			}
		}
		.mixed {
			chars = match ctx.charset {
				.alpha { rs.set_mixed }
				.alnum { rs.set_mixed_alnum }
				.ascii { rs.set_mixed_ascii }
				.hex { rs.set_mixed_hex }
				else { chars }
			}
		}
	}
	return chars
}
