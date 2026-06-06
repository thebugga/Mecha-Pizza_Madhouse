//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 u_colour;
uniform float alpha;
uniform float treshold;
uniform float smooth;

float color_sat;

// Thanks to Sam Hocevar for conversion codes. Source: http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl
// Code is licensed under the WTFPL.	Source: https://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}



void main()
{
    vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
	
	
	vec3 lum = vec3(0.2100, 0.7000, 0.0750);
	vec3 gray = vec3(dot(texColor.rgb, lum));
	vec3 sat = mix(gray, texColor.rgb, vec3(0.0));

	
	vec3 basicHSV = rgb2hsv(texColor.rgb);
	float basicHUE = basicHSV.x *254.0; 
	
	float tresholdA = u_colour.x - treshold;
	float tresholdB = u_colour.x + treshold;
	
	if((distance(basicHUE, u_colour.x)) < treshold)
	{
		float color_sat = distance(basicHUE, u_colour.x+((basicHUE > u_colour.x) ? treshold : -treshold) );
		color_sat = clamp(color_sat, 0.0, smooth) /smooth;
		sat.rgb = mix(gray, texColor.rgb, vec3(color_sat));
	}
	
	if(tresholdA < 0.0 && basicHUE > 254.0 - abs(tresholdA)) // LEFT TO RIGHT SIDE
	{
		
		float color_sat = distance( basicHUE, (254.0 - abs(tresholdA)) );
		color_sat = clamp(color_sat, 0.0, smooth) /smooth; 
		sat.rgb = mix(gray, texColor.rgb, vec3(color_sat));
	}
	
	if(tresholdB > 254.0 && basicHUE < tresholdB - 254.0) // RIGHT TO LEFT SIDE
	{
		
		float color_sat = distance( basicHUE, tresholdB - 254.0);
		color_sat = clamp(color_sat, 0.0, smooth) /smooth; 
		sat.rgb = mix(gray, texColor.rgb, vec3(color_sat));
		//sat.rgb = texColor.rgb;
	}
	
	gl_FragColor =  vec4(sat.rgb, texColor.a - (1.0 - alpha));

}

