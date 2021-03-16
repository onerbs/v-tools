module hush

import crypto.sha512

// SHA-384, SHA-512, SHA-512/224, and SHA-512/512

struct SHA384Husher {}

fn (h SHA384Husher) hash(s string) string {
	return sha512.hexhash_384(s)
}

fn (h SHA384Husher) hash_bytes(bs []byte) string {
	return sha512.sum384(bs).hex()
}

struct SHA512Husher {}

fn (h SHA512Husher) hash(s string) string {
	return sha512.hexhash(s)
}

fn (h SHA512Husher) hash_bytes(bs []byte) string {
	return sha512.sum(bs).hex()
}

struct SHA512_224Husher {}

fn (h SHA512_224Husher) hash(s string) string {
	return sha512.hexhash512_224(s)
}

fn (h SHA512_224Husher) hash_bytes(bs []byte) string {
	return sha512.sum512_224(bs).hex()
}

struct SHA512_512Husher {}

fn (h SHA512_512Husher) hash(s string) string {
	return sha512.hexhash512_512(s)
}

fn (h SHA512_512Husher) hash_bytes(bs []byte) string {
	return sha512.sum512_512(bs).hex()
}
