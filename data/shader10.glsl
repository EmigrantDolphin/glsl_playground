#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);

void main() {
    vec3 color = vec3(0.0);

    float mixPercentage = smoothstep(
        0,
        1,
        pow(abs(sin(u_time)), 10)
    );

    color = mix(colorA, colorB, mixPercentage);

    gl_FragColor = vec4(color, 1.0);
}