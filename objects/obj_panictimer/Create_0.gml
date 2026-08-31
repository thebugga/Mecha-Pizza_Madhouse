global.panic = {
	active: false,
	timer: 0,
	timer_max: 0
}

global.panicbg = 1
global.maxwave = 0
global.wave = 0
global.paniclayercount = 0
global.panicshadetimer = 0

john = {
	image_index: 0,
	image_speed: 0.35
}

pizzaface = {
	sprite_index: spr_timer_pizzaface_sleep,
	image_index: 0,
	image_speed: 0.35
}

barfill_x = 0
bar_surface = noone
showtime_buffer = 0

xstart = screen_w / 2
ystart = screen_h - 76
x = xstart
y = ystart + 212

im_speed = 1
fx_speed = 1.5

depth = 0
