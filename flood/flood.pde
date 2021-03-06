int size = int((float)Math.pow(2, 9)) + 1; // LEAVE 9 FOR 513
int stepSize = size - 1;
int variation = 10;
int highestPoint;
PVector highestPos;
boolean flood = false;
boolean transform = false;
int maxWater = 1000;
int lastWater = 0;
int buff = 0;
int mx = stepSize / 2;
int my = stepSize / 2;
int percentage = 0;
int lastTouched = 0;
int counter = 0;
int transTime = 15;

Pixel[][]pixel = new Pixel[size][size];
Water[]water = new Water[maxWater];

Pixel[]touchedPixel = new Pixel[size * size];

void setup() {
  frameRate(10);
  size(513, 513);
  colorMode(RGB);
  /*for (int i = 0; i < size; i++) {
     for (int j = 0; j < size; j++) {
     pixel[i][j] = new Pixel(float(i), float(j), int(random(0, 255)));
     }
  }*/
  /*
  pixel[0][0] = new Pixel(0, 0, int(random(0, 255)));
  pixel[size - 1][0] = new Pixel(size - 1, 0, int(random(0, 255)));
  pixel[0][size - 1] = new Pixel(0, size - 1, int(random(0, 255)));
  pixel[size - 1][size - 1] = new Pixel(size - 1, size - 1, int(random(0, 255)));
  */
  
  pixel[0][0] = new Pixel(0, 0, int(random(0, 50)));
  pixel[size - 1][0] = new Pixel(size - 1, 0, int(random(0, 50)));
  pixel[0][size - 1] = new Pixel(0, size - 1, int(random(0, 50)));
  pixel[size - 1][size - 1] = new Pixel(size - 1, size - 1, int(random(0, 50)));
  pixel[size / 2][size / 2] = new Pixel(size / 2, size / 2, int(random(230, 250)));
  
  print("\n---");

  while (stepSize > 1) {
    for (int i = 0; i < size - 1; i += stepSize) {
      for (int j = 0; j < size - 1; j += stepSize) {
        if (stepSize != size - 1) diamond(i, j, stepSize);
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
  print("\nHighest point: (" + highestPos.x + ", " + highestPos.y + "), " + highestPoint + " meters");
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
  if (lastWater == 0) touchedPixel[lastTouched++] = pixel[mx][my];
  if (flood && lastWater < maxWater) water[lastWater++] = new Water(mx, my);
  if (flood) {
    transform = false;
    for (int i = 0; i < lastWater; i++) {
      if (!water[i].isBasalt()) {
        print("\nWater " + i + ": (" + water[i].getX() + ", " + water[i].getY() + ")");
        int x = water[i].getX();
        int y = water[i].getY();
        int lh = pixel[x][y].getHeight();
        PVector lhPos = new PVector(x, y);
        for (int g = -1; g < 2; g++) {
          for (int h = -1; h < 2; h++) {
            if (x + g >= 0 && x + g <= size -1 && y + h >= 0 && y + h <= size - 1) {
              //print(" - (" + (x + g) + ", " + (y + h) + ")");
              if (pixel[x + g][y + h].getHeight() < lh) {
                lh = pixel[x + g][y + h].getHeight();
                lhPos = new PVector(x + g, y + h);
              }
            }
          }
        }
        if (lh == pixel[x][y].getHeight()) pixel[x][y].raiseHeight(1);
        else {
          if (pixel[int(lhPos.x)][int(lhPos.y)].isUnderWater()) {
            pixel[int(lhPos.x)][int(lhPos.y)].toBasalt();
            water[i].toBasalt();
          }
          touchedPixel[lastTouched++] = pixel[int(lhPos.x)][int(lhPos.y)];
          water[i].move(lhPos, pixel[x][y].getHeight());
          pixel[x][y].raiseHeight(5);
        }
      }
    
    if (lastWater == maxWater) lastWater = 0;
    }
  }
  else if (transform) {
    for (int i = 0; i < lastTouched; i++) {
      touchedPixel[i].transform(20);
    }
    counter++;
    print("\n" + int(((float(counter) * 100) / (float(transTime) * 100)) * 100) + "%");
    if (counter == transTime) {
      for (int i = 0; i < lastTouched; i++) {
        touchedPixel[i].transform(255);
      }
      print("\nDONE!");
      transform = false;
      lastWater = 0; 
      counter = 0;
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    if (flood) flood = false;
    else flood = true;
  }
  else if (key == ENTER || key == RETURN) {
    if (!flood) transform = true;
    else transform = false;
  }
}

void mousePressed() {
  mx = mouseX;
  my = mouseY;
  flood = true;
}
