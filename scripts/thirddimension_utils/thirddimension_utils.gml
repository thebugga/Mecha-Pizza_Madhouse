function vec2(_x, _y) constructor
{
	static add = function(_x, _y = 0)
	{
		if (is_struct(_x))
		{
			x += _x.x;	
			y += _x.y;
		}
		else
		{
			x += _x;
			y += _y;
		}
	}
	
	static multiply = function(_x, _y = 0)
	{
		if (is_struct(_x))
		{
			x *= _x.x;	
			y *= _x.y;
		}
		else
		{
			x *= _x;
			y *= _y;
		}
	}
	
	static divide = function(_x, _y = 0)
	{
		if (is_struct(_x))
		{
			x /= _x.x;	
			y /= _x.y;
		}
		else
		{
			x /= _x;
			y /= _y;
		}
	}
	
	
	x = _x;
	y = _y;
}

function vec3(_x, _y, _z) constructor
{
	static add = function(_x, _y = 0, _z = 0)
	{
		if (is_struct(_x))
		{
			x += _x.x;	
			y += _x.y;
			z += _x.z;
		}
		else
		{
			x += _x;
			y += _y;
			z += _z;
		}
	}
	
	static multiply = function(_x, _y = 0, _z = 0)
	{
		if (is_struct(_x))
		{
			x *= _x.x;	
			y *= _x.y;
			z *= _x.z;
		}
		else
		{
			x *= _x;
			y *= _y;
			z *= _z;
		}
	}
	
	static divide = function(_x, _y = 0, _z = 0)
	{
		if (is_struct(_x))
		{
			x /= _x.x;	
			y /= _x.y;
			z /= _x.z;
		}
		else
		{
			x /= _x;
			y /= _y;
			z /= _z;
		}
	}
	
	
	x = _x;
	y = _y;
	z = _z;
}
	
function draw_sprite_billboard_ext(_sprite, _subimage, _x, _y, _z, _xscale, _yscale, _zscale, _rotation, _color, _alpha)
{
	shader_set(shd_billboard);
	
    matrix_set(matrix_world, matrix_build(_x, _y, _z, 0, 0, 0, 1, 1, _zscale));
	
    draw_sprite_ext(_sprite, _subimage, 0, 0, _xscale, _yscale, 0, _color, _alpha);
	
    matrix_set(matrix_world, matrix_build_identity());
	
    shader_reset();	
}
	
function draw_sprite_billboard(_sprite, _subimage, _x, _y, _z)
{
	draw_sprite_billboard_ext(_sprite, _subimage, _x, _y, _z, 1, 1, 1, 0, c_white, draw_get_alpha());
}

function screen_to_world(_x, _y, _viewMat, _projectionMat) {
    /*
        Transforms a 2D coordinate (in window space) to a 3D vector.
        Returns an array of the following format:
        [dx, dy, dz, ox, oy, oz]
        where [dx, dy, dz] is the direction vector and [ox, oy, oz] is the origin of the ray.
        Works for both orthographic and perspective projections.
        Script created by TheSnidr
        (slightly modified by @dragonitespam)
    */
    
    var mx = 2 * (_x / window_get_width() - .5) / _projectionMat[0];
    var my = 2 * (_y / window_get_height() - .5) / _projectionMat[5];
    var camX = - (_viewMat[12] * _viewMat[0] + _viewMat[13] * _viewMat[1] + _viewMat[14] * _viewMat[2]);
    var camY = - (_viewMat[12] * _viewMat[4] + [13] * _viewMat[5] + _viewMat[14] * _viewMat[6]);
    var camZ = - (_viewMat[12] * _viewMat[8] + _viewMat[13] * _viewMat[9] + _viewMat[14] * _viewMat[10]);
    
    if (_projectionMat[15] == 0) {    //This is a perspective projection
        return new vec3(_viewMat[2]  + mx * _viewMat[0] + my * _viewMat[1], _viewMat[6]  + mx * _viewMat[4] + my * _viewMat[5], _viewMat[10] + mx * _viewMat[8] + my * _viewMat[9]);
    } else {    //This is an ortho projection
        return new vec3(_viewMat[2], _viewMat[6], _viewMat[10]);
    }
}

function draw_variables(_x, _y, _variables)
{
	var _str = "";
	for (var i = 0, _l = array_length(_variables); i < _l; i++)
	{
		_str += string_concat(_variables[i], " : ", variable_instance_get(self, _variables[i]), "\n");	
	}
	
	draw_text(_x, _y, _str);
}

