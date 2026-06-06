//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float color_strong;
uniform float gray_strong;
uniform float alpha;

void main()
{
	vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
	
	float lumR = 0.2100 * gray_strong;
	float lumG = 0.7000;
	float lumB = 0.0750 * gray_strong;
	
	
	vec3 lum = vec3(lumR, lumG, lumB);
	vec3 gray = vec3(dot(texColor.rgb, lum));
	vec3 sat = mix(gray, texColor.rgb, lum + vec3(-lum.r,-lum.g,-lum.b) + vec3(color_strong, color_strong, color_strong));

	gl_FragColor =  vec4(sat.rgb, texColor.a - (1.0 - alpha));
}