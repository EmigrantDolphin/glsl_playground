import java.io.FilenameFilter;

static final FilenameFilter FILTER = new FilenameFilter() {
  static final String NAME = "shader", EXT = ".glsl";

  @ Override boolean accept(File path, String name) {
    return name.startsWith(NAME) && name.endsWith(EXT);
  }
};


PShader shader;
boolean alreadyFocused = false;
PImage img;
int shaderNumber = 0;

String getCurrentShaderName() {
  return "shader" + shaderNumber + ".glsl";
}
void loadMyShader() {
  shader = loadShader(getCurrentShaderName());
  surface.setTitle(getCurrentShaderName());
}

void setup() {
  size(640, 360, P2D);
  noStroke();
  
  loadMyShader();
  img = loadImage("jim.jpg");
}

void draw() {
  tryHandleShader();
  
  if (!alreadyFocused && focused) {
    alreadyFocused = true;
    loadMyShader();
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

boolean doesFileExist(String fileName) {
  File f = dataFile(fileName);
  boolean exist = f.isFile();
  return exist;
}

// switches between shader files. Have to be names shaderN.glsl, where N is int [0, max]
void keyPressed() {
  if (keyCode == RIGHT) {
    shaderNumber++;
    if (doesFileExist(getCurrentShaderName()))
      loadMyShader();
    else {
      shaderNumber = 0;
      loadMyShader();
    }
  }
  
  if (keyCode == LEFT) {
    shaderNumber--;
    if (doesFileExist(getCurrentShaderName()))
      loadMyShader();
    else {
      File f = dataFile("");
      int shaderCount = f.list(FILTER).length;
      shaderNumber = shaderCount - 1;
      loadMyShader();
    }
  }
}
