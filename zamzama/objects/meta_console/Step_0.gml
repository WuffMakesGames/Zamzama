/// @description 

// Console
CONSOLE.update()

var pan_x = CONSOLE.memory.peek(CONSOLE.memory.map.pan_x.start)
var pan_y = CONSOLE.memory.peek(CONSOLE.memory.map.pan_y.start)
if (keyboard_check(vk_left))	CONSOLE.memory.poke(CONSOLE.memory.map.pan_x.start, pan_x-1)
if (keyboard_check(vk_right))	CONSOLE.memory.poke(CONSOLE.memory.map.pan_x.start, pan_x+1)
if (keyboard_check(vk_up))		CONSOLE.memory.poke(CONSOLE.memory.map.pan_y.start, pan_y-1)
if (keyboard_check(vk_down))	CONSOLE.memory.poke(CONSOLE.memory.map.pan_y.start, pan_y+1)