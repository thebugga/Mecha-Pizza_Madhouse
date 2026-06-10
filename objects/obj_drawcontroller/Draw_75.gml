var cw = camera_get_view_width(view_camera[0]) + 32;
var ch = camera_get_view_height(view_camera[0]) + 32;
var surf_x = camera_get_view_x(view_camera[0]);
var surf_y = camera_get_view_y(view_camera[0]);
if dark_lights
{
	if (!surface_exists(surf))
	{
		surf = surface_create(cw, ch);
	}
	if (surface_exists(surf))
	{
		surface_set_target(surf);
		draw_clear_alpha(c_black, 0);
		draw_set_color(c_black);
		draw_set_alpha(0.9);
		draw_rectangle(0, 0, cw, ch, false);
		gpu_set_blendmode(bm_subtract);
		draw_set_color(c_white);
		for (var i = 0; i < 2; i++)
		{
			var _player = asset_get_index(obj_player);
			draw_set_alpha(circle_alpha_out);
			with (_player)
			{
				draw_circle((x - surf_x) + irandom_range(-1, 1), (y - surf_y) + irandom_range(-1, 1), 148, false);
			}
			draw_set_alpha(circle_alpha_in);
			with (_player)
			{
				draw_circle((x - surf_x) + irandom_range(-1, 1), (y - surf_y) + irandom_range(-1, 1), 98, false);
			}
		}
		gpu_set_blendmode(bm_normal);
		draw_set_alpha(1);
		surface_reset_target();
		draw_surface(surf, 0, 0);
	}
}