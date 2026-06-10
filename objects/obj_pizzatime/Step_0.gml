var ty = down ? 120 : -sprite_height
var mvsp = down ? 2 : 1.5

shakemag = max(shake_mag - 0.5, 0)

y = approach(y, ty, mvsp) + irandom_range(shake_mag, -shake_mag)
		
if (down && y >= ty && alarm[0] == -1)
	alarm[0] = 80
else if (!down && y <= ty)
	instance_destroy()

x = screen_w / 2 + irandom_range(shake_mag, -shake_mag);
