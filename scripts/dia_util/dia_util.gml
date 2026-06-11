function dialog_create(_text, _namespr = noone, _endfunc = noone, _bgspr = bg_bunny, _charname = "BUNNY")
{
	return [_text, _namespr, _endfunc, _bgspr, _charname]; // last argument is never used afaik
}

function scr_string_width(_str)
{
	var pos = 0;
	var w = 0;
	var originalstr = _str;
	var str_arr = array_create(0);
	while (pos < string_length(originalstr))
	{
		if (string_copy(originalstr, pos, 2) == "\n")
		{
			array_push(str_arr, string_copy(originalstr, 1, pos));
			string_delete(originalstr, 1, pos);
			pos = 0;
			if (originalstr == "")
			{
				break;
			}
		}
		else
		{
			pos++;
		}
	}
	if (array_length(str_arr) == 0)
	{
		w = string_width(_str);
	}
	for (var i = 0; i < array_length(str_arr); i++)
	{
		var b = str_arr[i];
		if (string_width(b) > w)
		{
			w = string_width(b);
		}
	}
	return w;
}

function scr_separate_text (_str, _font = -4, _targetwidth = ((sprite_get_width(spr_tutorialbubble) * (960 - 64)) / sprite_get_width(spr_tutorialbubble)) - 32)
{
	if (_font != noone)
	{
		draw_set_font(_font);
	}
    while (scr_string_width(_str) > (960 - (rpadding * 2) - string_width("a")))
    {
        _pos = string_length(_str);
        _oldpos = _pos;
        
        while (string_char_at(_str, _pos) != " ")
        {
            _pos--;
            
            if (_pos < 0)
                _pos = _oldpos;
        }
        
        if (string_char_at(_str, _pos) == " ")
            _str = string_delete(_str, _pos, 1);
        
        _str = string_insert("\n", _str, _pos);
    }
	return _str;
}

function scr_is_separation(_seperator, _seperation)
{
	for (var i = 0; i < array_length(_seperation); i++)
	{
		if (_seperator == _seperation[i])
		{
			return true;
		}
	}
	return false;
}

function scr_calculate_text(_str)
{
	draw_set_font(fnt_caption);
	var pos = 0;
	var str2 = "";
	while (pos <= string_length(_str))
	{
		pos++;
		str2 = string_insert(string_char_at(_str, pos), str2, string_length(str2) + 1);
		str2 = scr_separate_text(str2);
	}
	return str2;
}

function scr_calculate_height(_str)
{
	var str2 = scr_calculate_text(_str);
	return string_height(str2);
}
function scr_draw_granny_texture(_x, _y, _width, _height, _tile_x, _tile_y, _tilespr = spr_tutorialbubble_bg, _bubblespr = spr_tutorialbubble)
{
	var w = sprite_get_width(_bubblespr) * _width;
	var h = sprite_get_height(_bubblespr) * _height;
	if (!surface_exists(surfclip))
	{
		surfclip = surface_create(w, h);
	}
	if (!surface_exists(surffinal))
	{
		surffinal = surface_create(w, h);
	}
	surface_set_target(surfclip);
	draw_clear_alpha(c_black, 0);
	draw_rectangle_color(0, 0, w, h, c_white, c_white, c_white, c_white, false);
	gpu_set_blendmode(bm_subtract);
	draw_sprite_ext(_bubblespr, 0, 0, 0, _width, _height, 0, c_white, 1);
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	surface_reset_target();
	surface_set_target(surffinal);
	draw_sprite_tiled(_tilespr, 0, _tile_x, _tile_y);
	gpu_set_blendmode(bm_subtract);
	draw_surface(surfclip, 0, 0);
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	surface_reset_target();
	draw_surface(surffinal, _x, _y);
}
function scr_draw_granny_texture2(_x, _y, _width, _height, _tile_x, _tile_y, _tilespr = spr_tutorialbubble_bg, _bubblespr = spr_tutorialbubble)
{
	var w = sprite_get_width(_bubblespr) * _width;
	var h = sprite_get_height(_bubblespr) * _height;
	if (!surface_exists(surfclip2))
	{
		surfclip2 = surface_create(w, h);
	}
	if (!surface_exists(surffinal2))
	{
		surffinal2 = surface_create(w, h);
	}
	surface_set_target(surfclip2);
	draw_clear_alpha(c_black, 0);
	draw_rectangle_color(0, 0, w, h, c_white, c_white, c_white, c_white, false);
	gpu_set_blendmode(bm_subtract);
	draw_sprite_ext(_bubblespr, 0, 0, 0, _width, _height, 0, c_white, 1);
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	surface_reset_target();
	surface_set_target(surffinal2);
	draw_sprite_tiled(_tilespr, 0, _tile_x, _tile_y);
	gpu_set_blendmode(bm_subtract);
	draw_surface(surfclip2, 0, 0);
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	surface_reset_target();
	draw_surface(surffinal2, _x, _y);
}

function do_dialog(_dialog)
{
	with (instance_create(x, y, obj_diacontroller))
	{
		npcID = other.id;
		dialog = _dialog;
		dialogsprite = dialog[0][1];
		currenttext = scr_calculate_text(dialog[0][0]);
		dialogheight = scr_calculate_height(currenttext);
		textbgpr = dialog[0][3];
		charactername = dialog[0][4];
	}
	with (obj_player)
	{
		sprite_index = spr_player_idle;
		image_speed = 0.35;
		state = states.actor;
		hsp = 0;
		vsp = 0;
		movespeed = 0;
	}
}

function npc_do_dialog()
{
	do_dialog(dialog);
}