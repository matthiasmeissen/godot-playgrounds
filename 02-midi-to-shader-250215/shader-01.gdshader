shader_type canvas_item;

uniform float size = 0.2;
uniform float bend = 1.0;
uniform float invert = 0;
uniform float flip = 0;

void vertex() {
	// Called for every vertex the material is visible on.
}

#define PI 3.14159265359
#define rot(a) mat2(vec2(cos(a), -sin(a)), vec2(sin(a), cos(a)))


vec3 col1(vec2 p, float s) {
    vec2 p1 = p;
    p1 = rot(TIME * 0.4) * p1;
    vec2 p2 = rot(p1.x) * p;
    float d1 = distance(p, vec2(cos(p2.x * 8.0), p.y)) * distance(p1, vec2(p.x, sin(p.y * 20.0)));
    d1 = step(d1, s);
    return vec3(d1);
}

void fragment() {
	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 p = (2.0 * FRAGCOORD.xy - resolution.x) / resolution.y;

	p = mix(p * 2.0, p * 0.5, bend);
	p = mix(p, vec2(1.0 - p.x, p.y), flip);
	vec3 col = mix(col1(p, size), 1.0 - col1(p, size), invert);

	vec3 color = vec3(col);

	COLOR = vec4(color, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
