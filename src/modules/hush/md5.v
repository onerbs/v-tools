module hush

import crypto.md5

struct MD5Husher {}

fn (h MD5Husher) hash(s string) string {
	return md5.hexhash(s)
}

fn (h MD5Husher) hash_bytes(bs []byte) string {
	return md5.sum(bs).hex()
}
