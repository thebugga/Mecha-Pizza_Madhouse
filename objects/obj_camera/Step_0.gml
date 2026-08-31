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
	    global.maxwave = (instance_exists(obj_tv) ? global.panic.timer_max : 4000)
	    global.wave = (global.panic.timer > 0 ? (global.maxwave - global.panic.timer) : (global.maxwave))
	}
	else if (global.panicshadetimer != 0)
	    global.panicshadetimer = 0
}
