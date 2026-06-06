/// @description Wstaw opis w tym miejscu
// W tym edytorze możesz zapisać swój kod
var _size = ds_list_size(outline_idList)

if(os_is_paused() and _size > 0)
{
	for(var i=0; i<_size; i++)
	{
		var _id = outline_idList[| i];
		if( surface_exists(outline_surfaces[? _id]) )
		{
			buffer_get_surface(outline_surfaces_buffer[? _id], outline_surfaces[? _id], 0)
		}
	}
	
}





