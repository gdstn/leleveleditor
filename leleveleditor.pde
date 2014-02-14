keey k=new keey(400, 100);
door d=new door(70, 60);
guy g=new guy(250, 350);
ArrayList<entity> ple=new ArrayList<entity>();
boolean remove=false;
boolean enmy=false;
boolean platform=false;
boolean mp=false;
boolean mr=false;
void mousePressed(){
  mp=true;
  if(keyPressed){
    
  }
}
void mouseReleased(){
  mr=true;
}

void draw(){
  background(255);
  k.render();
  d.render();
  g.render();
  for(int x=0; x<ple.size(); x++){
    ple.get(x).render();
    if(ple.get(x).rem)
    ple.remove(x);
  }
  mp=false;
  mr=false;
}
void setup(){
  size(500, 500);
  frameRate(30);
}
String i2s(int x){
  if(x<100)
  return "0"+x;
  else if(x<10)
  return "00"+x;
  else
  return Integer.toString(x);
}
abstract class entity{
  String id=new String();
  int x;
  int y;
  int w;
  boolean rem=false;
  boolean m=false;
  int dx=0;
  int dy=0;
  entity(int a, int b, int c){
    x=a;
    y=b;
    w=c;
  }
  void onclick(){
    dx=mouseX-x;
    dy=mouseY-y;
    m=true;
  }
  void onrelease(){
    m=false;
    dx=0;
    dy=0;
  }
   void render(){
     if(m){
     x=mouseX-dx;
     y=mouseY-dy;
     }
     if(mr){
       onrelease();
     }
   }
}
class door extends entity{
  door(int a, int b){
    super(a, b, 999);
    id="d"+i2s(a)+i2s(b)+"999";
  }
  void render(){super.render();
    fill(#E2DDC7);
    rect(x, y, 22, 58);
    ellipse(x+15, y+58/2, 5, 5);
    if(mp&&mouseinbox(x, x+22, y, y+58)){
       onclick();
     }
  }
}
class guy extends entity{
  guy(int a, int b){
    super(a, b, 999);
    id="g"+i2s(a)+i2s(b)+"999";
  }
  void render(){
    super.render();
    fill(255);
    ellipse(x, y+9, 18, 18);
    stroke(0);
    line(x-3, y+18, x, y+34);
    line(x, y+34, x+8, y+58 );
    line(x, y+34, x-6, y+58 );
    line(x-3, y+20, x-5, y+35);
    line(x-3, y+20, x+5, y+30);
    line(x+5, y+30, x+5, y+31);
    if(mp&&mouseinbox(x-9, x+9, y-9, y+58)){
       onclick();
     }
  }
}
class keey extends entity{
  keey(int a, int b){
    super(a, b, 999);
    id="k"+i2s(a)+i2s(b)+"999";
  }
  void render(){
    super.render();
      fill(#E2DDC7);
      rect(x+16, y-2, 2, 8);
      rect(x+12, y-2, 2, 8);
      rect(x, y-2, 20, 4);
      ellipse(x, y, 12, 12);
      if(mp&&mouseinbox(x-6, x+20, y-6, y+6)){
       onclick();
     }
  }
}
class platform extends entity{
  platform(int a, int b, int c){
    super(a, b, c);
    id="p"+i2s(a)+i2s(b)+i2s(c);
  }
  void render(){
    super.render();
    fill(#003D21);
    rect(x, y, w, 5);
  }
}

class enemy extends entity{
  enemy(int a, int b, int c){
    super(a, b, c);
    id="e"+i2s(a)+i2s(b)+i2s(c);
  }
  void render(){
    super.render();
    if(mp&&mouseinbox(x+w-20, x+w-20, y-20, y+20)){
       onclick();
     }
    stroke(#ff0000);
    line(x, y, x+w, y);
    stroke(0);
    fill(#A2B5AE);
    ellipse(x+w, y, 40+random(4), 40+random(4));
    line(x+w-10, y+12, x+w-5, y+10);
    line(x+w, y+12, x+w-5, y+10);
    line(x+w+5, y+10, x+w, y+12);
    line(x+w+5, y+10, x+w+10, y+12);
    fill(0);
    ellipse(x+w-5, y-5, random(4), random(4));
    ellipse(x+w+5, y-5, random(4), random(4));
  }
}

boolean mouseinbox(int xi, int xa, int yi, int ya){
  return (mouseX>xi&&mouseX<xa&&mouseY>yi&&mouseY<ya);
}

