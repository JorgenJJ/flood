class Pixel {
  PVector pos;
  int h;
  
  Pixel(float x, float y, int h) {
    pos = new PVector(x, y);
    this.h = h;
    print("\nx: " + pos.x + " y: " + pos.y + " height: " + h);
    if (h < 150) stroke(0, h + 50, 0);
    else stroke(h);
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
  
  void raiseHeight(int amount) {
    h += amount;
  }
}
