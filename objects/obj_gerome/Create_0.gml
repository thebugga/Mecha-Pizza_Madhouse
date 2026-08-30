if !global.panic.active
	sprite_index = choose(spr_gerome_idlemop, spr_gerome_idleeat, spr_gerome_idlesleep)
else
	sprite_index = spr_gerome_keyidle
image_speed = 0.35
depth = -2

