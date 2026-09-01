mag = 0
mag_decel = 0.5
cam_charge = 0
info_visible = false

campos = {
	x: 0,
	y: 0
}

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_colour();
vertexFormat = vertex_format_end();
global.cubeMesh = importObj("gamedata/models/cube.obj", vertexFormat);
global.slopeMesh = importObj("gamedata/models/slope.obj", vertexFormat);
camera = view_camera[0];
chargecamera = 0;
camDist = -1050;
camFov = 30;
camAsp = camera_get_view_width(camera) / camera_get_view_height(camera);
gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);
gpu_set_texrepeat(true);
