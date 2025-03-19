varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 palette[768];
uniform vec4 clipping_region;

uniform sampler2D vramTex;
uniform vec2 tilemapSize;
uniform vec2 vramSize;

uniform vec2 tileSize;
uniform float tiles_x;
uniform float tileStart;

bool inside_box(vec2 point, vec2 top_left, vec2 bottom_right) {
	return point.x == clamp(point.x, top_left.x, bottom_right.x) && point.y == clamp(point.y, top_left.y, bottom_right.y);
}

void main()
{
	float offset_x = mod(v_vTexcoord.x*tilemapSize.x*tileSize.x, tileSize.x);
	float offset_y = mod(v_vTexcoord.y*tilemapSize.y*tileSize.y, tileSize.y);
	
	float tile = texture2D(gm_BaseTexture, v_vTexcoord).r * 255.0 + tileStart;
	
	float image_x = (1.0/vramSize.x) * (offset_x + mod(tile,tiles_x)*tileSize.x);
	float image_y = (1.0/vramSize.y) * (offset_y + floor(tile/tiles_x)*tileSize.y);
	
	int index = int(texture2D(vramTex, vec2(image_x, image_y)).r * 255.0);
	
	float alpha = float(inside_box(vec2(gl_FragCoord), clipping_region.xy, clipping_region.zw));
	alpha = alpha * float(index != 0 && tile != 0.0);
	
	gl_FragColor = vec4(palette[index], alpha);
}
