shader_type canvas_item;

uniform float blur: hint_range(0.0, 2.5);
uniform float brightness: hint_range(0.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = textureLod(TEXTURE,SCREEN_UV,blur);
	COLOR.rgb *= brightness;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
