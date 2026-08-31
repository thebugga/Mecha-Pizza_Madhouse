function panicbg_update()
{
	var a = layer_get_all()
	var b = []
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
		layer_script_begin(b[j], panicbg_get_bgs)
	    layer_script_end(b[j], panicbg_draw)
	}
}

function panicbg_get_bgs()
{
    var _cam_w = camera_get_view_width(view_camera[0])
    var _cam_h = camera_get_view_height(view_camera[0])
    if ((!variable_global_exists("panicbg_surface")) || (!surface_exists(global.panicbg_surface)))
        global.panicbg_surface = surface_create(_cam_w, _cam_h)
	gpu_set_blendenable(false);
	surface_set_target(global.panicbg_surface)
	draw_clear_alpha(c_black, 0);
	var a = layer_get_all()
	for (var i = 0; i < array_length(a); i++)
	{
		var _cam_x = camera_get_view_x(view_camera[0])
		var _cam_y = camera_get_view_y(view_camera[0])
		if (string_copy(layer_get_name(a[i]), 1, 12) == "Backgrounds_" || string_copy(layer_get_name(a[i]), 1, 11) == "Foreground_" || string_copy(layer_get_name(a[i]), 1, 7) == "Assets_")
		{
			layer_x(a[i], (layer_get_x(a[i]) - abs(_cam_x)))
			layer_y(a[i], (layer_get_y(a[i]) - abs(_cam_y)))
		}
	}
}

function panicbg_draw()
{
    var _cam_w = camera_get_view_width(view_camera[0])
    var _cam_h = camera_get_view_height(view_camera[0])
    var _cam_x = 0
    var _cam_y = -50
    surface_reset_target()
	gpu_set_blendenable(true);
	gpu_set_zwriteenable(true);
	if (global.panic.active && global.panicbg != 0)
	{
	    shader_set(shd_panicbg)
	    var panic_id = shader_get_uniform(shd_panicbg, "panic")
	    shader_set_uniform_f(panic_id, (global.wave / global.maxwave))
	    var time_id = shader_get_uniform(shd_panicbg, "time")
	    shader_set_uniform_f(time_id, (global.panicshadetimer / 1000))
	}
    draw_surface_tiled_ext(global.panicbg_surface, _cam_x, _cam_y, 1.2, 1.2, c_white, 1)
	if (global.panic.active && global.panicbg != 0)
		shader_reset()
}