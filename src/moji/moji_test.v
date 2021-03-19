module main

import moji

fn test_get_items() {
	assert moji.get_items(':sparkles:') == [':sparkles:']
	assert moji.get_items(':kiss:::mango:') == [':kiss:', ':mango:']
	assert moji.get_items('::: :::dolphin: :') == [':dolphin:']
	assert moji.get_items(': :art::brain:a:') == [':art:', ':brain:']
	assert moji.get_items(':hello world::rainbow::') == [':rainbow:']
	assert moji.get_items('::whale::a:') == [':whale:', ':a:']
	assert moji.get_items('::owl: : :rose: :swan::') == [':owl:', ':rose:', ':swan:']
}
