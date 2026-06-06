function draw_player(){
	image_blend = c_white
	
	var roomname = room_get_name(room);
	roomname = string_letters(roomname);
	
	var xx = x
	var yy = y

	if visual_size == 0
		exit;

	if hitstun > 0
	{
		var range = 5
		xx += irandom_range(-range, range)
		yy += irandom_range(-range, range)
	}

	if sprite_index == spr_player_walkfront
		image_blend = make_color_hsv(0, 0, (1 - ((image_number - image_index) / image_number)) * 255)

	image_alpha = 1

	if (i_frames > 0 && state != states.hurt && state != states.fireass)
		image_alpha = round(wave(0, 1, 0.01, 0))

	if pal_select == 12
		pattern_draw(sprite_index, image_index, xx, yy, pattern_spr, xscale * visual_size, image_yscale * visual_size, image_angle, image_blend, image_alpha)

	pal_swap_set(pal_peppino, pal_select, false)
	if room == town_sewer1
		outline_draw_sprite_ext(sprite_index, image_index, xx, yy, xscale * visual_size, image_yscale * visual_size, image_angle, image_blend, image_alpha, ol_config(2, #9850F8, 1, 1))
	else
		draw_sprite_ext(sprite_index, image_index, xx, yy, xscale * visual_size, image_yscale * visual_size, image_angle, image_blend, image_alpha)
	pal_swap_reset()

	if flash > 0
	{
		shader_set(shd_flash)
		draw_sprite_ext(sprite_index, image_index, xx, yy, xscale * visual_size, image_yscale * visual_size, image_angle, image_blend, image_alpha)
		shader_reset()
	}

	with uparrow
	{
		if visible
			draw_sprite(sprite_index, image_index, other.x, other.y + yoffset)
		image_index += image_speed
	}
}

function draw_enemy()
{
	depth = -50
	
	var roomname = room_get_name(room);
	roomname = string_letters(roomname);

	var _x = x
	var _y = y

	if alarm[0] >= 0
	{
		var range = 5
		_x += irandom_range(-range, range)
		_y += irandom_range(-range, range)
	}

	if follow_player
	{
		if obj_player.state == states.piledriver
		{
			_y += 48
			if obj_player.sprite_index == spr_player_piledriver
			{
				_x += pd_frame_offset[floor(obj_player.image_index)] * 8 * obj_player.xscale
				if (obj_player.image_index > 5)
					depth = -210
			}
		}
		else if obj_player.sprite_index == spr_player_swingding
		{
			_x += pd_frame_offset[floor(obj_player.image_index)] * 24 * obj_player.xscale
			if (obj_player.image_index < 4)
				depth = -210
		}
	}

	if state == states.stun && stun_timer > 100
	{
		draw_sprite(spr_enemybird, bird_ix, x, y - 40)
		bird_ix = wrap(sprite_get_number(spr_enemybird), bird_ix + 0.35)
	}
	else
		bird_ix = 0

	if room == town_sewer1
		outline_draw_sprite_ext(sprite_index, image_index, _x, _y, xscale - (warp * xscale), yscale + warp, image_angle, image_blend, image_alpha, ol_config(2, #9850F8, 1, 1))
	else
		draw_sprite_ext(sprite_index, image_index, _x, _y, xscale - (warp * xscale), yscale + warp, image_angle, image_blend, image_alpha)
	
	if (flash)
	{
		shader_set(shd_flash)
		draw_sprite_ext(sprite_index, image_index, _x, _y, xscale - (warp * xscale), yscale + warp, image_angle, image_blend, image_alpha)
		shader_reset()
	}
}

function draw_boss()
{
	depth = -50

	var xx = x
	var yy = y

	if hitstun > 0
	{
		var range = 5
		xx += irandom_range(-range, range)
		yy += irandom_range(-range, range)
	}

	if state == states.stun && !vulnerable
		image_alpha = wave(1, 0.5, 0.5, 0)
	else
		image_alpha = 1

	draw_sprite_ext(sprite_index, image_index, _x, _y, xscale - (warp * xscale), yscale + warp, image_angle, image_blend, image_alpha)

	if flash || (vulnerable && round(wave(0, 1, 0.25, 0)) == 1)
	{
		shader_set(shd_flash)
		draw_sprite_ext(sprite_index, image_index, xx, yy, xscale - (warp * xscale), yscale + warp, image_angle, image_blend, image_alpha)
		shader_reset()
	}
}