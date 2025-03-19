varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 palette[96];
uniform vec4 palettes[32];

uniform sampler2D texture;
uniform vec2 textureSize;
uniform vec2 tilemapSize;
uniform vec2 offset;

uniform vec2 tileSize;

// Shader
void main()
{
	vec4 pixel = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	vec2 pixelCoord = mod(v_vTexcoord * tilemapSize * tileSize, tileSize);
	float tile = floor(pixel.r * 255.0);
	
	float tilesX = floor(textureSize.x / tileSize.x);
	float imageX = (1.0 / textureSize.x) * (pixelCoord.x + mod(tile, tilesX) * tileSize.x);
	float imageY = (1.0 / textureSize.y) * (pixelCoord.y + floor(tile/tilesX) * tileSize.y);
	
	int index = int(texture2D(texture, vec2(imageX, imageY)).r * 255.0);
	int pal_id = int(pixel.g * 255.0);
    
	gl_FragColor = vec4(float(index)/255.0, 0, 0, 1.0);
}
