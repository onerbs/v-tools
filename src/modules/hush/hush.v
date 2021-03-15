module hush

pub interface Husher {
	hash(s string) string
	hash_bytes(bs []byte) string
}

pub fn get_husher(kind string) Husher {
	return match(kind) {
		'sha1' {
			Husher(SHA1Husher{})
		}
		else {
			Husher(MD5Husher{})
		}
	}
}
