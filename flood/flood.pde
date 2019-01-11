int size = int((float)Math.pow(2, 9)) + 1; // LEAVE 9 FOR 513
int stepSize = size - 1;
int variation = 5;

Pixel[][]pixel = new Pixel[size][size];

void setup() {
  frameRate(60);
  size(400, 400);
  colorMode(RGB);
  /*for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      pixel[i][j] = new Pixel(float(i), float(j), int(random(0, 255)));
    }
  }*/
  pixel[0][0] = new Pixel(0, 0, int(random(0, 255)));
  pixel[size - 1][0] = new Pixel(size - 1, 0, int(random(0, 255)));
  pixel[0][size - 1] = new Pixel(0, size - 1, int(random(0, 255)));
  pixel[size - 1][size - 1] = new Pixel(size - 1, size - 1, int(random(0, 255)));
  
  print("\n---");
  
  while (stepSize > 1) {
    for (int i = 0; i < size - 1; i += stepSize) {
      for (int j = 0; j < size - 1; j += stepSize) {
        diamond(i, j, stepSize);
      }
    }
    for (int i = stepSize / 2; i < size; i += stepSize) {
      for (int j = stepSize / 2; j < size; j += stepSize) {
        square(i, j, stepSize);
      }
    }
    stepSize /= 2;
    print("\nstepSize = " + stepSize);
  }
}

void diamond(int x, int y, int stepSize) {
  print("\nX: " + x + " Y: " + y);
  int avg = 0;
  avg += pixel[x][y].getHeight();
  avg += pixel[x + stepSize][y].getHeight();
  avg += pixel[x][y + stepSize].getHeight();
  avg += pixel[x + stepSize][y + stepSize].getHeight();
  avg /= 4;
  
  pixel[x + stepSize / 2][y + stepSize / 2] = new Pixel(float(x + (stepSize / 2)), float(y + (stepSize / 2)), 
  avg + int(random(variation * -1, variation)));
}

void square(int x, int y, int stepSize) {
  print("\nX: " + x + " Y: " + y);
  int avg = 0;
  avg += pixel[x - (stepSize / 2)][y - (stepSize / 2)].getHeight();
  avg += pixel[x + (stepSize / 2)][y - (stepSize / 2)].getHeight();
  avg += pixel[x - (stepSize / 2)][y + (stepSize / 2)].getHeight();
  avg += pixel[x + (stepSize / 2)][y + (stepSize / 2)].getHeight();
  avg /= 4;
  
  pixel[x][y - (stepSize / 2)] = new Pixel(float(x), float(y - (stepSize / 2)), 
  avg + int(random(variation * -1, variation)));
  pixel[x - (stepSize / 2)][y] = new Pixel(float(x - (stepSize / 2)), float(y), 
  avg + int(random(variation * -1, variation)));
  pixel[x + (stepSize / 2) - 1][y] = new Pixel(float(x + (stepSize / 2)), float(y), 
  avg + int(random(variation * -1, variation)));
  pixel[x][y + (stepSize / 2) - 1] = new Pixel(float(x), float(y + (stepSize / 2)), 
  avg + int(random(variation * -1, variation)));
}
