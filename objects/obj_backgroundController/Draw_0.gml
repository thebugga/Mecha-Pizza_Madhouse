if (!surface_exists(backGroundSurface))
{
     backGroundSurface = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
}

surface_set_target(backGroundSurface);

draw_clear_alpha(c_black, 0);
var _sprite = bg_entrance1;
var _cameraPos = new vec2(obj_camera.campos.x, -obj_camera.campos.y);
show_debug_message(array_length(layers));
for (var _b = 0; _b < array_length(layers); _b++)
{
    var _cB = layers[_b];
    with (_cB)
    {
        var _t = (current_time / 10);
        var _x = obj_camera.campos.x * parallaxSpeed[0] + (_t * scrollSpeed[0]);
        var _y = obj_camera.campos.y * parallaxSpeed[1] + (_t * scrollSpeed[1]);

        if (moveFunc != -4)
        {
            _x = moveFunc().x;
            _y = moveFunc().y;
        }

        if (drawFunc != -4)
        {
            drawFunc(_sprite, _cameraPos, image_index);
        }
        else
        {
            draw_sprite_tiled(_sprite, image_index, _x, _y);        
        }
    }
}

surface_reset_target();
gpu_set_blendenable(false);

gpu_set_blendenable(true);
gpu_set_zwriteenable(true);