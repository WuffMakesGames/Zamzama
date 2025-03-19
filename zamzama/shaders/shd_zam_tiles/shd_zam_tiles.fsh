varying vec2 v_vTexcoord;
varying vec4 v_vColour;

sampler2D Tilemap;
vec2 Scroll;

vec2 CanvasSize;
vec2 TileSize;
float TilesX;

void main()
{
	vec2 PixelCoord = v_vTexcoord*CanvasSize;
	float tileID = int(texture2D(gm_BaseTexture, v_vTexcoord + Scroll/TileSize).r * 255.0);
	
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
}
