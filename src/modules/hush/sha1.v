module hush

import crypto.sha1

struct SHA1Husher {}

fn (h SHA1Husher) hash(s string) string {
	return sha1.hexhash(s)
}

fn (h SHA1Husher) hash_bytes(bs []byte) string {
	return sha1.sum(bs).hex()
}
