
																					//////////////////////////////////
																					//			SOLID COLOR			//
																					//////////////////////////////////
	
function draw_sprite_solidcolor(sprite_index, image_index, x, y, color, xscale = image_xscale, yscale = image_yscale, rot = image_angle, alpha = image_alpha)
{
	shader_set(shSolidcolor)
	var new_color = shader_get_uniform(shSolidcolor, "u_colour");													//////////////////////////////////////////////////////////////////////////////////
	var colors_array = [																							//																				//
    color_get_red(color)/255,																						//		EXAMPLE (draw_event):													//
    color_get_green(color)/255,																						//		draw_sprite_solidcolor(sprite_index, image_index, x, y, c_yellow)		//
    color_get_blue(color)/255,																						//																				//
	alpha																											// ---------------------------------------------------------------------------- //
	];																												//		I think the variables are clear to understand.							//
	shader_set_uniform_f_array(new_color, colors_array);															//		Remember that variables with [] brackets are optional, and they have	//
	if(visible) draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, rot, image_blend, 1)				//		deafult values.															//
	shader_reset();																									//																				//
																													//////////////////////////////////////////////////////////////////////////////////
}

function shader_set_solidcolor(color, alpha)
{
	shader_set(shSolidcolor)
	var new_color = shader_get_uniform(shSolidcolor, "u_colour");													//////////////////////////////////////////////////////////////////////////////////
	var colors_array = [																							//																				//
    color_get_red(color)/255,																						//		EXAMPLE (draw_event):													//
    color_get_green(color)/255,																						//		shader_set_solidcolor(c_red, 1)											//
    color_get_blue(color)/255,																						//		draw_self()																//
	alpha																											//		draw_sprite(sLaser, 0, x ,y)											//
	];																												//																				//
	shader_set_uniform_f_array(new_color, colors_array);															//////////////////////////////////////////////////////////////////////////////////
	
	//dont forget to add shader_reset() at the end of codes
}




																					//////////////////////////////////
																					//			 OUTLINE			//
																					//////////////////////////////////
	
function draw_sprite_outline_auto(sprite_index, image_index, x, y, outline_color, outline_size, outline_alpha = 1, xscale = image_xscale, yscale = image_yscale, rot = image_angle, sprite_color = image_blend,  alpha = image_alpha)
{
	if(sprite_index < 0) return 0;
	#region CREATE SURFACE
	if(!instance_exists(SHADER_CONTROLLER)) instance_create_depth(-999,-999,0,SHADER_CONTROLLER);													//////////////////////////////////////////////////////////////////////////////////
	surf = ds_map_find_value(SHADER_CONTROLLER.outline_surfaces, id)																				//																				//
																																					//		EXAMPLE (draw_event):													//
																																					//		draw_sprite_outline_auto(sprite_index, image_index, x, y, c_red, 3)		//
	if(surf == undefined)																															//																				//
	{																																				// ---------------------------------------------------------------------------- //
		surf = surface_create(room_width, room_height);																								//		I think the variables are clear to understand.							//
		ds_map_replace(SHADER_CONTROLLER.outline_surfaces, id, surf);																				//		Remember that variables with [] brackets are optional, and they have	//
		ds_map_replace(SHADER_CONTROLLER.outline_surfaces_buffer, id, buffer_create(room_width * room_height * 4, buffer_grow, 1) );				//		deafult values.															//
																																					//																				//
		ds_list_add(SHADER_CONTROLLER.outline_idList, id);																							//	!!	YOU DONT HAVE TO UNCHECK AUTO CROP, OR MAKING MORE SPACE IN SPRITES	!!	//
	}																																				//	!!	THIS METHOD DOESN'T REQUIRE THAT									!!	//
	else																																			//																				//
	{																																				//////////////////////////////////////////////////////////////////////////////////
		if(!surface_exists(surf))
		{
			surf = surface_create(room_width, room_height);
			ds_map_replace(SHADER_CONTROLLER.outline_surfaces, id, surf);
			buffer_set_surface(SHADER_CONTROLLER.outline_surfaces_buffer[? id], surf, 0);
		}
		
		if(surface_get_width(surf) != room_width or surface_get_height(surf) != room_height) surface_resize(surf, room_width, room_height);
	}
	#endregion

	surface_set_target(surf);
		draw_clear_alpha(c_white,0);
		draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, rot, sprite_color, 1);
	surface_reset_target();


	////////////// SHADER

	shader_set(shOutline)
	var _outline_color = shader_get_uniform(shOutline, "outline_colour");
	var colors_array = [
	color_get_red(outline_color)/255,
	color_get_green(outline_color)/255,
	color_get_blue(outline_color)/255,
	];
	shader_set_uniform_f_array(_outline_color, colors_array);	
	
	var _width = shader_get_uniform(shOutline, "tex_width")
	var _height = shader_get_uniform(shOutline, "tex_height")
	var _size = shader_get_uniform(shOutline, "size")
	var _alpha = shader_get_uniform(shOutline, "alpha");
	var _spritealpha = shader_get_uniform(shOutline, "sprite_alpha");

	
	var surf_texture = surface_get_texture(surf);
	var tex_width = texture_get_texel_width(surf_texture)
	var tex_height = texture_get_texel_height(surf_texture)
	
	shader_set_uniform_f(_width, tex_width);
	shader_set_uniform_f(_height, tex_height);
	shader_set_uniform_f(_size, outline_size);
	shader_set_uniform_f(_alpha, outline_alpha);
	shader_set_uniform_f(_spritealpha, alpha);


	if(visible) draw_surface_ext(surf, 0, 0,1,1,0, c_white, alpha);
	shader_reset();
}




																					//////////////////////////////////
																					//		  EXTRACT COLOR			//
																					//////////////////////////////////
	
function shader_set_extractcolor(color, alpha = 1, treshold = 15, smooth = 1)
{
	shader_set(shExtractcolor)																			
	var new_color = shader_get_uniform(shExtractcolor, "u_colour");										//////////////////////////////////////////////////////////////////////////////
	var _alpha = shader_get_uniform(shExtractcolor, "alpha");											//																			//
	var _thr = shader_get_uniform(shExtractcolor, "treshold");											//		EXAMPLE (draw_event):												//
	var _smooth = shader_get_uniform(shExtractcolor, "smooth");											//		shader_set_extractcolor(c_green, 1, 20, 10)							//
																										//		draw_self()															//
	var colors_array = [																				//		draw_sprite(sHouse, 0, 200, 250)									//
    color_get_hue(color),																				//		shader_reset() <-- MOST IMPORTANT									//
    color_get_saturation(color),																		//																			//
    color_get_value(color),																				// ------------------------------------------------------------------------ //
	];																									//		color: color to extract												//
	shader_set_uniform_f_array(new_color, colors_array);												//		alpha: alpha...														//
	shader_set_uniform_f(_alpha, alpha);																//		treshold: range of color to be extracted (0 - 255)					//
	shader_set_uniform_f(_thr, treshold);																//		smooth: range of transistion of boundaries colors (1 - treshold)	//
	shader_set_uniform_f(_smooth, smooth);																//																			//
 																										//////////////////////////////////////////////////////////////////////////////
	//dont forget to add shader_reset() at the end of codes
}




																					//////////////////////////////////
																					//			GREYSCALE			//
																					//////////////////////////////////
																					
function draw_sprite_greyscale(sprite_index, image_index, x, y, color_strong, gray_strong = 1, xscale = image_xscale, yscale = image_yscale, rot = image_angle, alpha = image_alpha)
{
	shader_set(shGreyscale)
	var _colorStrong = shader_get_uniform(shGreyscale, "color_strong");									//////////////////////////////////////////////////////////////////////////
	var _grayStrong = shader_get_uniform(shGreyscale, "gray_strong");									//																		//
	var _alpha = shader_get_uniform(shGreyscale, "alpha");												//		EXAMPLE (draw_event):											//
																										//		draw_sprite_greyscale(sprite_index, image_index, x, y, 0)		//
	shader_set_uniform_f(_colorStrong, color_strong);													//																		//
	shader_set_uniform_f(_grayStrong, gray_strong);														// -------------------------------------------------------------------- //
	shader_set_uniform_f(_alpha, alpha);																//	  color_strong: 0 - grey       1 - normal   2  - over saturate		//
																										//	   gray_strong: 0 - dark grey  1 - normal   2 - light gray			//
	if(visible) draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, rot, image_blend, 1)	//																		//
	shader_reset();																						//////////////////////////////////////////////////////////////////////////
}

function shader_set_greyscale(color_strong, gray_strong = 1)
{
	shader_set(shGreyscale)																					 /////////////////////////////////////////////////////////////
	var _colorStrong = shader_get_uniform(shGreyscale, "color_strong");										 //														    //
	var _grayStrong = shader_get_uniform(shGreyscale, "gray_strong");										 //		EXAMPLE (draw_event):								//
	var _alpha = shader_get_uniform(shGreyscale, "alpha");													 //		shader_set(shGreyscale)							    //
																											 //		draw_self();										//
	shader_set_uniform_f(_colorStrong, color_strong);														 //		draw_sprite(sSword, 0, oPlayer.x, oPlayer.y)		//
	shader_set_uniform_f(_grayStrong, gray_strong);															 //		draw_sprite(sShield, 0, oPlayer.x, oPlayer.y)		//
	shader_set_uniform_f(_alpha, draw_get_alpha());															 //		shader_reset() <-- MOST IMPORTANT					//			
																											 //															//
	//dont forget to add shader_reset() at the end of codes													 /////////////////////////////////////////////////////////////
}


