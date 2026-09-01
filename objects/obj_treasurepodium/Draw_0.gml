matrix_set(matrix_world, matrix_build(x, y, -75, 0, 0, 0, sprite_width, -sprite_height, 64));

vertex_submit(global.cubeMesh, pr_trianglelist, sprite_get_texture(sprite_index, 0));

matrix_set(matrix_world, matrix_build_identity());

if (treasure_sprite != noone && treasure)
	draw_sprite(treasure_sprite, 0, x, y - 20)
