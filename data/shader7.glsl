#ifdef GL_ES
    precision lowp float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;

float getDistance(vec2 firstPos, vec2 secondPos) {
    return sqrt(pow(firstPos.x - secondPos.x, 2.0) + pow(firstPos.y - secondPos.y, 2.0));
}

vec4 visualAxes() {
	vec2 pixelPosition = gl_FragCoord.xy/u_resolution;
    vec2 mousePosition = u_mouse.xy / u_resolution;
    mousePosition = vec2(mousePosition.x, 1 - mousePosition.y);


    float radius = 0.1;
    float distance = getDistance(pixelPosition, mousePosition);
    if (distance < radius) {
        // value between 0 and 1, 
        float gradual = smoothstep(0, radius, distance);
        // return vec4(0, 0, 0, 1 - gradual); //weird alpha since no background
        // return vec4(pixelPosition.x * gradual, pixelPosition.y * gradual, 0, 1 - gradual); // looks like a slime
        return vec4(pixelPosition.x * gradual, pixelPosition.y * gradual, 0, 1); // intended
    }

	return vec4(pixelPosition, 0 , 1.0);
}

void main() {
    gl_FragColor = visualAxes();
}


//NOTE: There is an interesting effect when you follow the ball with your eyes.
// If you go to a yellow area, it feels like the whole window is brighter.
// If you go to a black area it feels like the whole window is dimmer.
// Even though nothing changes. Wonder if I could use it somewhere...
// It looks a little like a slime 

//I think it's because there is no background, so the alpha value doesn't do anything.