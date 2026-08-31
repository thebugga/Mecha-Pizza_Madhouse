var _margin = 400
if (x > room_width + _margin ||
	x < -_margin ||
	y > room_height + _margin ||
	y < -_margin)
	instance_destroy()
