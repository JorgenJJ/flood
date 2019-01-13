class Pixel {
  PVector pos;
  int h;
  boolean underWater = false;
  
  Pixel(float x, float y, int h) {
    pos = new PVector(x, y);
    this.h = h;
    //print("\nx: " + pos.x + " y: " + pos.y + " height: " + h);
    if (h > 150) stroke(h);
    else if (h < 100) {
      stroke(0, 0, h + 100);
      underWater = true;
    }
    else stroke(0, h + 50, 0);
    point(pos.x, pos.y);
  }
  
  int getX() {
    return int(pos.x);
  }
  
  int getY() {
    return int(pos.y);
  }
  
  int getHeight() {
    return h;
  }
  
  void flood() {
    underWater = true;
  }
  
  boolean isUnderWater() {
    return underWater;
  }
  
  void raiseHeight(int amount) {
    h += amount;
  }
  
  void toBasalt() {
    raiseHeight(50);
    underWater = false;
    stroke(h / 2, h / 2, h / 2);
    point(pos.x, pos.y);
  }
}
