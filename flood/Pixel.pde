class Pixel {
  PVector pos;
  int h;
  
  Pixel(PVector pos, int h) {
    this.pos = pos;
    this.h = h;
    fill(h);
    rect(pos.x, pos.y, pos.x, pos.y);
  }
}
