#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

// Plot a line on Y using a value between 0.0-1.0
float plot(vec2 pixelPosition, float y){
	// first smoothstep create a triangle with some displacement.
	// second smoothstep does the same, but displaced in different direction.
	// Then first smoothstep has values like 0 0 0.1 0.5 0.9 1   1   1   1 1 1 1
	// and second smoothstep has values like 0 0 0   0   0   0.1 0.5 0.9 1 1 1 1
	// If you substract first smoothstep from second, you get a line that smoothes in and smoothes out. Only vertically. 
	// But if you draw it on x, and calculate y from x, it will look like a draw line/graph
	return smoothstep( y-0.02, y, pixelPosition.y) -
	smoothstep( y, y+0.02, pixelPosition.y);
}

vec4 currentExperiment() {
	vec2 pixelPosition = gl_FragCoord.xy/u_resolution;

    float y = pixelPosition.x;

	// Plot a line
	float pct = plot(pixelPosition, y);

	//This creates a triangle of black-to-white gradient. 
	//step with two values returns 0 or 1. First arg is threshold, second is value. So step(0.5, 1) == 1. step(0.5, 0.2) == 0
	// Then it substracts step from 1 to show the gradient below the line.
	vec3 color = vec3(y) * 1-step(y, pixelPosition.y);

	// First part before adding draws the white color but not on a line. That's why we take the line, substract 1 to make it 0 and multiply by color.
	// second part adds the line with custom color on top, because it is removed by first part.
	color = (1 - pct) * color   +   pct * vec3(1.0,0.5,0.01);

	return vec4(color,1.0);
}

void main() {
	gl_FragColor = currentExperiment();
}