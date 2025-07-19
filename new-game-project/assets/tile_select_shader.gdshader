shader_type spatial;
render_mode  unshaded;//cull_front

uniform vec3 color : source_color = vec3(.5,0,.5);
uniform float thickness : hint_range(0.0, 0.0, 0.4) = 0.0;

void vertex() {
	VERTEX += thickness*NORMAL;
}

void fragment() {
	ALBEDO = color;
}