var _w = 960
var _h = 540;
var ds_h = 0;
var x1 = rpadding + text_wave_x;
var _yscale = dialogheight + rpadding + (padding * 2) + ds_h;
var y1 = _h - _yscale - 60 + text_wave_y;
var y2 = _yscale / text_sprite_height;

if (y2 < 1)
    y2 = 1;

tex_x -= 0.5;

draw_set_alpha(0.5)
draw_rectangle_color(0, 0, screen_w, screen_h, c_black, c_black, c_black, c_black, false)
draw_set_alpha(1)

// character sprite
if (dialogsprite != -4)
    draw_sprite(dialogsprite, -1, x1 + padding + 80, y1 + (padding / 2));

// name bubble
scr_draw_granny_texture2(x1 - 15, y1 - 85, 2, 1, tex_x, tex_x, textbgpr, bubblepr)
draw_sprite_ext(spr_computerbubble, 1, x1 - 15, y1 - 85, 2, 1, 0, c_white, 1);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_font(global.tutorialfont);
draw_text_color(x1 + 75, y1 - 75, "my name is", c_black, c_black, c_black, c_black, 1);
draw_set_font(global.creditsfont);
draw_text_color(x1 + 75, y1 - 45, charactername, c_white, c_white, c_white, c_white, 1);

// actual bubble
draw_set_font(global.creditsfont);
draw_sprite(spr_tutorialbubble_rope, 0, 64 + text_wave_x, 540 + text_wave_y);
draw_sprite(spr_tutorialbubble_rope, 0, (960 - 64) + text_wave_x, 540 + text_wave_y);
scr_draw_granny_texture(x1, y1, text_xscale, y2, tex_x, tex_x, textbgpr, bubblepr)
draw_sprite_ext(spr_computerbubble, 1, x1, y1, text_xscale, y2, 0, c_white, 1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_color(x1 + padding, y1 + padding + ds_h, "* " + displaytext, c_white, c_white, c_white, c_white, 1);