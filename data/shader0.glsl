// Shows rg, xy value positions from 0,0 (bottom left) to 1,1 (top right).

#ifdef GL_ES
    precision mediump float; //precision of float variable. Lower precision, faster rendering/calculation
#endif

uniform vec2 u_resolution;

vec4 visualAxes() {
	// gl_fragCoord returns a pixel position. So we have to divide it by resolution to get a value from 0 to 1
	vec2 pixelPosition = gl_FragCoord.xy/u_resolution;

	return vec4(pixelPosition, 0 , 1.0);
}

void main() {
    gl_FragColor = visualAxes();
}