function player_doublejump()
{
	sprite_index = spr_player_doublejump
	hsp = p_move * movespeed
	if (p_move != 0)
	{
		if (p_move != xscale)
		{
			if (movespeed > 0)
			{
				movespeed -= 0.7
			}
			if (movespeed <= 0)
			{
				xscale = p_move
			}
		}
		else if (movespeed < 8)
		{
			movespeed += 0.7
		}
	}
	else
	{
		movespeed = approach(movespeed, 0, 0.7)
	}
	if (!jumpstop)
	{
		if (!input_check_pressed(INPUTS.jump) && vsp < 0.5)
		{
			vsp /= 20
			jumpstop = true
		}
		else if scr_solid(x, y - 1)
		{
			vsp = grav
			jumpstop = true
		}
	}
	if (grounded && vsp > 0 && !place_meeting(x, y + vsp, obj_destroyable))
	{
		state = states.normal
	}
	with (obj_destroyable)
	{
		if (place_meeting(x - other.hsp, y, other) || place_meeting(x - other.xscale, y, other) || place_meeting(x, y - other.vsp, other) || place_meeting(x, y + 2, other))
		{
			instance_destroy()
			if (other.vsp < 0)
			{
				other.vsp = -14
			}
			else if (other.vsp > -11)
			{
				other.vsp = -11
			}
		}
	}
	if (place_meeting(x + xscale, y, obj_solid) && !place_meeting(x + xscale, y, obj_destroyable))
		movespeed = 0
	do_grab()
}