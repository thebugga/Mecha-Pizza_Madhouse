if global.level_data.lap2
{
	draw_set_alpha(0.5)
	draw_set_color(#F87018)
	gpu_set_blendmode(bm_min);
	draw_rectangle(0, 0, window_get_width(), window_get_height(), false)
	gpu_set_blendmode_normal_fixed()
	draw_set_alpha(1)
	draw_set_color(c_white)
}