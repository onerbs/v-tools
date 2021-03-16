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
		'sha224' {
			Husher(SHA224Husher{})
		}
		'sha256' {
			Husher(SHA256Husher{})
		}
		'sha384' {
			Husher(SHA384Husher{})
		}
		'sha512' {
			Husher(SHA512Husher{})
		}
		'sha512_224', 'sha512/224' {
			Husher(SHA512_224Husher{})
		}
		'sha512_512', 'sha512/512' {
			Husher(SHA512_512Husher{})
		}
		else {
			Husher(MD5Husher{})
		}
	}
}
