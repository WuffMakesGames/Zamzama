/// @description 

// Console
CONSOLE.update()

var pan_x = CONSOLE.memory.peek(CONSOLE.memory.map.pan_x.start)
var pan_y = CONSOLE.memory.peek(CONSOLE.memory.map.pan_y.start)
if (keyboard_check(vk_left))	CONSOLE.memory.poke(CONSOLE.memory.map.pan_x.start, pan_x-1)
if (keyboard_check(vk_right))	CONSOLE.memory.poke(CONSOLE.memory.map.pan_x.start, pan_x+1)
if (keyboard_check(vk_up))		CONSOLE.memory.poke(CONSOLE.memory.map.pan_y.start, pan_y-1)
if (keyboard_check(vk_down))	CONSOLE.memory.poke(CONSOLE.memory.map.pan_y.start, pan_y+1)

if (keyboard_check_pressed(ord("1"))) CONSOLE.audio.note(ZAM_SAMPLE.bottle, 0, 0.5)
if (keyboard_check_pressed(ord("2"))) CONSOLE.audio.note(ZAM_SAMPLE.organ, 0, 0.5)
if (keyboard_check_pressed(ord("3"))) CONSOLE.audio.note(ZAM_SAMPLE.snare, 0, 0.5)
if (keyboard_check_pressed(ord("4"))) CONSOLE.audio.note(ZAM_SAMPLE.doo, 0, 0.5)
