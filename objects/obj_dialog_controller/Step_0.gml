var noelle_v = v_noelle
text_xscale = (960 - 64) / sprite_get_width(spr_tutorialbubble);
if (textbuffer > 0)
{
	audio_stop_sound(noelle_v)
	textbuffer--;
}
else
{
	currentpos++;
    if (currentpos <= string_length(currenttext))
    {
        var letter = string_char_at(currenttext, currentpos);
        var letterstr = letter;
        
        if (letter == "[")
        {
            while (letter != "]")
            {
                currentpos++;
                letter = string_char_at(currenttext, currentpos);
                letterstr += letter;
            }
        }
        
        displaytext = string_insert(letterstr, displaytext, string_length(displaytext) + 1);
        displaytext = scr_separate_text(displaytext);
        textbuffer = textspeed;
		if textbgspr == bg_noelle
		{
			scr_sound(noelle_v)
		}
    }
	else if (input_check_pressed(INPUTS.jump))
	{
		if (currentdialog < (array_length(dialog) - 1))
		{
			currentdialog++;
			currentpos = 0;
			textbuffer = textspeed;
			displaytext = "";
			currenttext = scr_calculate_text(dialog[currentdialog][0]);
			dialogheight = scr_calculate_height(currenttext);
			dialogsprite = dialog[currentdialog][1];
			textbgspr    = dialog[currentdialog][2];
			charactername    = dialog[currentdialog][3];
			var func = dialog[currentdialog][4];
			if (func != noone)
			{
				if (npcID != noone && instance_exists(npcID))
				{
					with (npcID)
					{
						method(id, func)();
					}
				}
				else
				{
					method(id, func)();
				}
			}
		}
		else
		{
			var endfunc = dialog[currentdialog][5];
			if (endfunc != noone)
			{
				if (npcID != noone && instance_exists(npcID))
				{
					with (npcID)
					{
						method(id, endfunc)();
					}
				}
				else
				{
					method(id, endfunc)();
				}
			}
			with obj_player
			{
				player_state = states.normal
			}
			//audio_stop_sound(vsfx)
			audio_stop_sound(noelle_v)
			instance_destroy();
		}
	}	
	else 
	{	
		audio_stop_sound(noelle_v)
	}
}

wave_timer += 20;
text_wave_x = wave(-5, 5, 2, 10, wave_timer);
text_wave_y = wave(-1, 1, 4, 0, wave_timer);