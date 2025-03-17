varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 textureSize;

void main()
{
	vec2 PixelCoord = v_vTexcoord * textureSize;
	float byte = texture2D(gm_BaseTexture, v_vTexcoord).r * 255.0;
	
	int index = int(mod(PixelCoord.x, 4.0));
	int crumb = int(mod(floor(byte / pow(4.0, float(index))), 4.0));
	
    gl_FragColor = vec4(float(crumb)/3.0, 0, 0, 1);
}
