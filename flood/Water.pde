class Water {
  PVector pos;
  
  Water(float x, float y) {
    pos = new PVector(x, y);
    stroke(0, 0, 150);
    fill(200, 0, 200);
    point(pos.x, pos.y);
  }
  
  int getX() {
    return int(pos.x);
  }
  
  int getY() {
    return int(pos.y);
  }
  
  void move(PVector pos) {
    this.pos = pos;
  }
}