
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform vec3 outline_colour;

uniform float tex_width;
uniform float tex_height;

uniform float size;
uniform float alpha;		// OUTLINE ALPHA
uniform float sprite_alpha;	// SPRITE ALPHA

vec4 outline = vec4(0.0);

float Pi = 3.14;

vec2 lengthdir(float width, float height, float _dir)
{
	float len_x = (width * cos(_dir * Pi/180.0));
	float len_y = -(height * sin(_dir * Pi/180.0));

	return vec2(len_x, len_y);
}


void main()
{
	vec4 outline = vec4(0.0);
	vec4 basicTex = texture2D(gm_BaseTexture, v_vTexcoord);
	
	
	float _quality = size*2.0; // 1.5 for performance, 2.0 for good quality, 3.0 for excellent quality
	float _dir = 360.0/_quality;


	for(float i = 0.0; i < _quality; i++)
	{
		vec2 len = lengthdir(tex_width*size, tex_height*size, (_dir*i) );
		outline +=  texture2D(gm_BaseTexture, v_vTexcoord + (vec2(len.x, len.y)) );
		outline.rgb = outline_colour.rgb;
	}
	


	if(outline.w > 0.0) outline.rgba = vec4(outline_colour.rgb, 1.0 - (1.0 - alpha));	

	if(basicTex.w > 0.0)
	{
		outline.rgba = vec4(basicTex.rgb, 1.0 - (1.0 - sprite_alpha));	
	}


	
	gl_FragColor = outline;
	
}