if escape_frozen
{
	visible = false
	
	if (abs(obj_player.x - self.x) <= 500 && abs(obj_player.y - self.y) <= 100 && alarm[1] == -1 && global.panic.active)
	{
		with create_effect(x, y - 20, spr_pillarenemyspawner)
			image_speed = 0.5
		alarm[1] = 16
	}
	
	exit;
}

do_enemy_generics()
collide()


if (grounded && scr_slope(x, y + 1))
{
    with instance_place(x, y, obj_slope)
    {
        var _dir = sign(image_xscale) 
        var angle_rad = arctan2(image_yscale * _dir, image_xscale * _dir)
        other.image_angle = radtodeg(angle_rad)
    }
}
else
    image_angle = 0