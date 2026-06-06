if hitstun > 0
{
	hitstun--
	exit;
}

switch state
{
	case states.normal:
		boss_normal()
		if alarm[1] == -1 || alarm[2] == -1
			alarm[choose(1, 2)] = 100;
		alarm_set(3, 30)
		break;
	case states.stun:
		boss_stun()
		if anim_ended() && sprite_index == spr_pepperman_shoulderhurt
			image_index = 3
		if has_touched_le_wall >= 3
			has_touched_le_wall = 0
		break;
	case states.hit:
		boss_hit()
		break;
	case states.pm_attack:
		hsp += xscale * 0.65
		if scr_solid(x + xscale, y)
		{
			shake_camera()
			scr_sound_3d(sfx_groundpound, x, y)
			audio_stop_sound(sfx_peppermanrun)
			particle_create(x, y, particles.bang)
			hurtplayer = false
			stun_timer = 120
			hsp = -5 * xscale
			xscale *= -1
			vsp = -5
			has_touched_le_wall++
			vulnerable = true
			state = has_touched_le_wall >= 3 ? states.stun : states.pm_attack
			sprite_index = has_touched_le_wall >= 3 ? spr_pepperman_shoulderhurt : spr_pepperman_run
		}
		break;
	case states.pm_bat:
		hurtplayer = false
		if sprite_index == spr_pepperman_run
		{		
			if hsp <= 8
			hsp += 0.5 * xscale
			if scr_solid(x + xscale, y)
			{
				shake_camera()
				scr_sound_3d(sfx_groundpound, x, y)
				audio_stop_sound(sfx_peppermanrun)
				particle_create(x, y, particles.bang)
				hurtplayer = false
				stun_timer = 120
				hsp = -12 * xscale
				xscale *= -1
				vsp = -12
				vulnerable = true
				state = states.stun
				sprite_index = spr_pepperman_shoulderhurt
			}
		}
	
		if sprite_index == spr_pepperman_run && place_meeting(x, y, obj_player)
		{
			hsp = 0
			vsp = 0
			reset_anim(spr_pepperman_hit)
		}
		if sprite_index == spr_pepperman_hit
		{
			if floor(image_index) < 45
			{
				with obj_player
				{
					state = states.actor
					sprite_index = spr_player_hurt
				}
			}
			else
			{
				with obj_player
				{
					sprite_index = spr_player_ball
					movespeed = 18
					vsp = -35
					xscale *= -1
					state = states.ball
					if (i_frames <= 0)
						do_hurt(other)
				}
				scr_sound(sfx_cheer)
				hurtplayer = true
				state = states.normal
				show_scorenew = true
				x = xstart
				alpha_flash = true
				sprite_index = spr_pepperman_idle
			}
		}
	break;
}

if audio_is_playing(sfx_cheer)
	yy = approach(yy, 544, 2.7)
else 
	yy = approach(yy, 736, 6)

do_vulnerability()

if blur_timer > 0
	blur_timer--
else if state == states.hit
{
	afterimage_create(after_images.blur)
	blur_timer = 2
}

if (obj_player.state == states.taunt)
{
	scared_timer = 0
	stun_timer = 0
}

warp = approach(warp, 0, 0.025)

if flash > 0
	flash--

var en_list = ds_list_create()
instance_place_list(x, y, par_enemy, en_list, false)

for (var i = 0; i < ds_list_size(en_list); i++) {
    var _id = ds_list_find_value(en_list, i)
	if place_meeting(x, y, _id)
	{
		if _id.state == states.hit
			instance_destroy()
	}
}

if vulnerable && !audio_is_playing(sfx_vulnerable)
	scr_sound(sfx_vulnerable, true)
else if !vulnerable && audio_is_playing(sfx_vulnerable)
	audio_stop_sound(sfx_vulnerable)

ds_list_destroy(en_list)
break_destroyables()
collide()

if afterimage_timer <= 0 && hurtplayer
{
	afterimage_timer = 6
	afterimage_create_color(223, 47, 0)
}
else
	afterimage_timer--
