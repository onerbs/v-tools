module moji

pub fn parse(s string) string {
	mut line := s
	item_list := get_items(line)
	for item in item_list {
		emoji := string(data[item])
		if emoji.len > 0 {
			line = line.replace_once(item, emoji)
		}
	}
	return line
}

fn get_items(s string) []string {
	mut item_list := []string{}
	mut item := []byte{}
	mut active := false
	for c in s {
		if c == `:` {
			active = !active
			if !active {
				if item.len == 0 {
					continue
				}
				tmp := string(item)
				item_list << ':$tmp:'
				item = []byte{}
			}
		} else if active {
			item << c
		}
	}
	return item_list
}
