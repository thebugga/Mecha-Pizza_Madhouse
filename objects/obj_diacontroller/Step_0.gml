text_xscale = (960 - 64) / sprite_get_width(spr_tutorialbubble);
if (text_xscale != text_oldxscale)
    event_perform(ev_other, ev_room_start);
if (textbuffer > 0)
{
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
			if (surface_exists(surfclip))
				surface_free(surfclip);
			if (surface_exists(surffinal))
				surface_free(surffinal);
			var func = dialog[currentdialog][2];
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
			instance_destroy();
		}
	}
}
if (currentpos < string_length(currenttext) && input_check_pressed(INPUTS.jump))
{
	while (currentpos <= string_length(currenttext))
	{
		currentpos++;
		displaytext = string_insert(string_char_at(currenttext, currentpos), displaytext, string_length(displaytext) + 1);
		displaytext = scr_separate_text(displaytext);
	}
}
wave_timer += 20;
text_wave_x = wave(-5, 5, 2, 10, wave_timer);
text_wave_y = wave(-1, 1, 4, 0, wave_timer);