function player_clingwall() 
{
    hsp = 0;
    vsp = min(vsp, 3);
    image_speed = 0.4;
	
	if sprite_index != spr_player_clingwall2
		sprite_index = spr_player_clingwall
	
	if input_check_pressed(INPUTS.jump)
	{
		sprite_index = spr_player_clingwall2
		scr_sound_3d_on(myemitter, sfx_explosion)
		create_effect(x, y, spr_explosion)
		state = states.superjump
		vsp = -12
	}
	
    if (grounded)
    {
        state = states.normal;
        image_speed = 0.35;
        sprite_index = spr_player_idle;
    }
}