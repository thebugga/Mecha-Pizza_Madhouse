var yp = 22;
draw_set_font(global.smallerfont);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(c_white);
draw_sprite(spr_roomnamebg, 0, x, y);
draw_text(x, y + yp, global.roommessage);
