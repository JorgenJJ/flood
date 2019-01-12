int size = int((float)Math.pow(2, 8)) + 1; // LEAVE 9 FOR 513
int stepSize = size - 1;
int variation = 20;
int highestPoint;
PVector highestPos;
boolean flood = false;
int maxWater = 1000;
int lastWater = 0;
int buff = 0;

Pixel[][]pixel = new Pixel[size][size];
Water[]water = new Water[maxWater];

void setup() {
  frameRate(5);
  size(257, 257);
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
  print("\nHighest point: (" + highestPos.x + ", " + highestPos.y + ")");
}

void diamond(int x, int y, int stepSize) {
  print("\nX: " + x + " Y: " + y);
  int avg = 0;
  avg += pixel[x][y].getHeight();
  avg += pixel[x + stepSize][y].getHeight();
  avg += pixel[x][y + stepSize].getHeight();
  avg += pixel[x + stepSize][y + stepSize].getHeight();
  avg /= 4;

  int h = int(random(variation * -1, variation));
  if (h > highestPoint) {
    highestPoint = h;
    highestPos = new PVector(x + stepSize / 2, y + stepSize / 2);
  }

  pixel[x + stepSize / 2][y + stepSize / 2] = new Pixel(float(x + (stepSize / 2)), float(y + (stepSize / 2)), 
    avg + h);
}

void square(int x, int y, int stepSize) {
  print("\nX: " + x + " Y: " + y);
  int avg = 0;
  avg += pixel[x - (stepSize / 2)][y - (stepSize / 2)].getHeight();
  avg += pixel[x + (stepSize / 2)][y - (stepSize / 2)].getHeight();
  avg += pixel[x - (stepSize / 2)][y + (stepSize / 2)].getHeight();
  avg += pixel[x + (stepSize / 2)][y + (stepSize / 2)].getHeight();
  avg /= 4;

  int h1 = int(random(variation * -1, variation));
  if (h1 > highestPoint) {
    highestPoint = h1;
    highestPos = new PVector(x, y - stepSize / 2);
  }  
  int h2 = int(random(variation * -1, variation));
  if (h2 > highestPoint) {
    highestPoint = h2;
    highestPos = new PVector(x - stepSize / 2, y);
  }  
  int h3 = int(random(variation * -1, variation));
  if (h3 > highestPoint) {
    highestPoint = h3;
    highestPos = new PVector(x + stepSize / 2, y);
  }  
  int h4 = int(random(variation * -1, variation));
  if (h4 > highestPoint) {
    highestPoint = h4;
    highestPos = new PVector(x, y + stepSize / 2);
  }

  pixel[x][y - (stepSize / 2)] = new Pixel(float(x), float(y - (stepSize / 2)), 
    avg + h1);
  pixel[x - (stepSize / 2)][y] = new Pixel(float(x - (stepSize / 2)), float(y), 
    avg + h2);
  pixel[x + (stepSize / 2)][y] = new Pixel(float(x + (stepSize / 2)), float(y), 
    avg + h3);
  pixel[x][y + (stepSize / 2)] = new Pixel(float(x), float(y + (stepSize / 2)), 
    avg + h4);
}

void draw() {
  if (flood) water[lastWater++] = new Water(highestPos.x, highestPos.y);
  if (buff < maxWater) buff = lastWater;
  for (int i = 0; i < buff; i++) {
    print("\nWater " + i + ": (" + water[i].getX() + ", " + water[i].getY() + ")");
    int x = water[i].getX();
    int y = water[i].getY();
    int lh = pixel[x][y].getHeight();
    PVector lhPos = new PVector(x, y);
    for (int g = -1; g < 2; g++) {
      for (int h = -1; h < 2; h++) {
        print(" - (" + (x + g) + ", " + (y + h) + ")");  
        if (pixel[x + g][y + h].getHeight() < lh) {
          lh = pixel[x + g][y + h].getHeight();
          lhPos = new PVector(x + g, y + h);
        }
      }
    }
    if (lh == pixel[x][y].getHeight()) pixel[x][y].raiseHeight(1);
    else water[i].move(lhPos);
  }

  if (lastWater == maxWater) lastWater = 0;
}

void keyPressed() {
  if (key == ENTER || key == RETURN) {
    if (flood) flood = false;
    else flood = true;
  }
}
