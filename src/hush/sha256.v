module hush

import crypto.sha256

struct SHA224Husher {}

fn (h SHA256Husher) hash(s string) string {
	return sha256.hexhash_224(s)
}

fn (h SHA256Husher) hash_bytes(bs []byte) string {
	return sha256.sum224(bs).hex()
}

struct SHA256Husher {}

fn (h SHA256Husher) hash(s string) string {
	return sha256.hexhash(s)
}

fn (h SHA256Husher) hash_bytes(bs []byte) string {
	return sha256.sum(bs).hex()
}
