//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
uniform vec4 u_colour;

void main()
{
    vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
	
    gl_FragColor = vec4(u_colour.rgb, texColor.a - (1.0 - u_colour.a));
}