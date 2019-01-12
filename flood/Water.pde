class Water {
  PVector pos;
  
  Water(float x, float y) {
    pos = new PVector(x, y);
    stroke(255, 71, 0);
    fill(200, 0, 200);
    point(pos.x, pos.y);
  }
  
  int getX() {
    return int(pos.x);
  }
  
  int getY() {
    return int(pos.y);
  }
  
  void move(PVector pos, int h) {
    this.pos = pos;
    if (h > 255) h = 255;
    stroke(211, h / 2, 0);
    point(pos.x, pos.y);
  }
}
