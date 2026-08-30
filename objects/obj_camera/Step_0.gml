if instance_exists(obj_player) && !(room_width == 960 && room_height == 540)
{
	var target = obj_player

	var target_spd = 0
	var appr_spd = 10
	
	if target.hitstun <= 0
	{
		if (target.state == states.mach2 || target.state == states.mach3)
		{
			target_spd = target.xscale * ((target.movespeed / 4) * 50)
			appr_spd = 0.35
		}
		else if ((abs(target.hsp) >= 16 || (target.state == states.taunt && abs(target.prev.hsp) >= 16)) && target.state != states.climbwall && target.state != states.superjump)
		{
			target_spd = (target.xscale * ((abs(target.movespeed) / 4) * 50))
			appr_spd = 2
			if ((target_spd > 0 && cam_charge < 0) || (target_spd < 0 && cam_charge > 0))
				appr_spd = 8
		}
	}
	
	cam_charge = approach(cam_charge, target_spd, appr_spd)
	
	if (global.panic.active && global.panicbg != 0)
	{
	    global.panicshadetimer++
	    var a = layer_get_all()
	    var b = []
	    global.paniclayercount = 0
	    for (var i = 0; i < array_length(a); i++)
	    {
	        if (string_copy(layer_get_name(a[i]), 1, 12) == "Backgrounds_" || string_copy(layer_get_name(a[i]), 1, 7) == "Assets_" || string_copy(layer_get_name(a[i]), 1, 11) == "Foreground_")
	        {
	            b[global.paniclayercount] = a[i]
	            global.paniclayercount++
	        }
	    }
	    for (var j = 0; j < array_length(b); j++)
	    {
	        layer_script_begin(b[j], scr_panicbg_start)
	        layer_script_end(b[j], scr_panicbg_end)
	    }
	    global.maxwave = (instance_exists(obj_tv) ? global.panic.timer_max : 4000)
	    global.wave = (global.panic.timer > 0 ? (global.maxwave - global.panic.timer) : (global.maxwave))
	}
	else if (global.panicshadetimer != 0)
	    global.panicshadetimer = 0
}
