PShader shader;
boolean alreadyFocused = false;
PImage img;


void setup() {
  size(640, 360, P2D);
  noStroke();
  
  shader = loadShader("shader.glsl");
  img = loadImage("jim.jpg");
}

void draw() {
  tryHandleShader();
  
  if (!alreadyFocused && focused) {
    alreadyFocused = true;
    shader = loadShader("shader.glsl");
  } else if (!focused) {
    alreadyFocused = false;
  }
}


void tryHandleShader() {
  try {
    shader.set("u_resolution", float(width), float(height));
    shader.set("u_mouse", float(mouseX), float(mouseY));
    shader.set("u_time", millis() / 1000.0);
    shader(shader);
    rect(0,0,width,height);
  } catch(Exception e) {
    background(img);
  }
}
