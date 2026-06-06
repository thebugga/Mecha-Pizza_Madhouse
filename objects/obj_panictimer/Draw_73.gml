if global.level_data.lap2
{
	draw_set_alpha(0.2)
	draw_set_color(#F87018)
	gpu_set_blendmode(bm_add);
	draw_rectangle(0, 0, room_width, room_height, false)
	gpu_set_blendmode_normal_fixed()
	draw_set_alpha(1)
	draw_set_color(c_white)
}