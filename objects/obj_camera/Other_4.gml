view_enabled = true
view_visible[0] = true
camera_set_view_size(view_camera[0], screen_w, screen_h)
if instance_exists(obj_player)
{
	x = obj_player.x;
	y = obj_player.y;
}

var lay_id = layer_get_id("Background_color");
var back_id = layer_background_get_id(lay_id);

if !layer_background_exists(lay_id, back_id)
{
	var back = layer_create(9000, "Background_color")
	var create = layer_background_create(back, -4)
	layer_background_blend(create, c_black)
}

layer_depth(layer_get_id("Instances"), 0)
layer_depth(layer_get_id("Instances_1"), 0)

layer_depth(layer_get_id("Backgrounds_1"), 60)
layer_depth(layer_get_id("Backgrounds_2"), 80)

layer_depth(layer_get_id("Tiles_1"), -100)
layer_depth(layer_get_id("Tiles_2"), -100)
layer_depth(layer_get_id("Tiles_3"), -100)
layer_depth(layer_get_id("Tiles_4"), -100)
layer_depth(layer_get_id("Tiles_BG"), 100)
layer_depth(layer_get_id("Tiles_BG2"), 100)

var roomname = room_get_name(room);
roomname = string_letters(roomname);
	