/// @desc
/*
if(!ds_exists(outline_idList, ds_type_list)) exit;

var _size = ds_list_size(outline_idList)
if(_size > 0)
{
	for(var i=0; i<_size; i++)
	{
		surface_free(outline_surfaces[? outline_idList[| i]])
		surface_free(outline_surfaces_buffer[? outline_idList[| i]])
	}
	
	ds_map_destroy(outline_surfaces);
	ds_map_destroy(outline_surfaces_buffer);
	ds_list_destroy(outline_idList);
}






