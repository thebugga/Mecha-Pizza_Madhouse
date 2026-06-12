if (input_check_pressed(INPUTS.up) && other.state == states.normal)
{
	dialog_func();
	if (!audio_is_playing(v_bunny_ithinkyea) && !audio_is_playing(v_bunny_ithinkyeayeayea)) && voice_break == 0
	{
		scr_sound_3d_pitched(choose(v_bunny_ithinkyea,v_bunny_ithinkyeayeayea),x,y)
		voice_break = 30
	}
}