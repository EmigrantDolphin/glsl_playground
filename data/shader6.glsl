
#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

// Plot a line on Y using a value between 0.0-1.0
float plot(vec2 pixelPosition, float y){
	return smoothstep( y-0.02, y, pixelPosition.y) -
	smoothstep( y, y+0.02, pixelPosition.y);
}

vec4 currentExperiment() {
	vec2 pixelPosition = gl_FragCoord.xy/u_resolution;

	float y = 
	(
		smoothstep(0.2, 0.5, (pixelPosition.x + ((sin(u_time)) / 2)))
		- smoothstep(0.5, 0.8, (pixelPosition.x + ((sin(u_time)) / 2)))
	)
	* (smoothstep(0, 0.5, pixelPosition.x) - smoothstep(0.5, 1, pixelPosition.x));

	// Plot a line
	float pct = plot(pixelPosition, y);

	vec3 color = vec3(y) * 1-step(y, pixelPosition.y);

	color = (1 - pct) * color+pct * vec3(1.0,0.5,0.01);

	return vec4(color,1.0);
}

void main() {
	gl_FragColor = currentExperiment();
}