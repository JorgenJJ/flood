class Pixel {
  PVector pos;
  int h;
  
  Pixel(float x, float y, int h) {
    pos = new PVector(x, y);
    this.h = h;
    print("\nx: " + pos.x + " y: " + pos.y + " height: " + h);
    stroke(h);
    rect(pos.x, pos.y, pos.x, pos.y);
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
}
