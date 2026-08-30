if instance_exists(obj_player)
{
	campos = {
		x: obj_player.x - (screen_w / 25),
		y: obj_player.y - (screen_h / 25) - 50,
	}

	if obj_player.state == states.backtohub
		campos.y = obj_player.ystart - (screen_h / 25) - 50

	campos.x += cam_charge

	if (room_width == 960 && room_height == 540)
	{
	    campos.x = 480;
	    campos.y = 270;
	}

	if global.panic.active && !global.secret
		mag = 1

	if mag > 0 && global.option_screenshake
	{
		campos.x += irandom_range(-mag, mag)
		campos.y += irandom_range(-mag, mag)
	}

	mag = max(mag - mag_decel, 0)

	if !obj_player.secret_exit && obj_player.sprite_index != spr_pizzaportalend
		camera_set_view_pos(view_camera[0], campos.x, campos.y)
}
