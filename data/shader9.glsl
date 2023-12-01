#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);

void main() {
    vec3 color = vec3(0.0);

    float pct = abs(sin(u_time));

    // mix the two colors based on percentage. when pct is 0, left color has is multiplied by one, when pct is 1 right color is multiplied by 1
    color = mix(colorA, colorB, pct);

    gl_FragColor = vec4(color,1.0);
}