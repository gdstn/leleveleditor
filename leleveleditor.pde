String data="k409394999d438430999g388430999e081351141p257303081p191110103";
String newdata="";
keey k=new keey(400, 100);
door d=new door(70, 60);
guy g=new guy(250, 350);
ArrayList<entity> ple=new ArrayList<entity>();
boolean remove=false;
boolean enemy=false;
boolean platform=false; 
boolean mp=false;
boolean mr=false;
int px=0;
int py=0;
void parsedata(String dat){
  for(int x=0; x<dat.length(); x+=10){
    if(dat.charAt(x)=='k'){
      k.x=parseInt(dat.substring(x+1, x+4));
      k.y=parseInt(dat.substring(x+4, x+7));
    
    }
    else if(dat.charAt(x)=='g'){
      g.x=parseInt(dat.substring(x+1, x+4));
      g.y=parseInt(dat.substring(x+4, x+7));
      
    }
    else if(dat.charAt(x)=='d'){
      d.x=parseInt(dat.substring(x+1, x+4));
      d.y=parseInt(dat.substring(x+4, x+7));
      
    }
    else if(dat.charAt(x)=='e'){
      ple.add(new enemy(parseInt(dat.substring(x+1, x+4)), parseInt(dat.substring(x+4, x+7)), parseInt(dat.substring(x+7, x+10))));
      
    }
    else if(dat.charAt(x)=='p'){
      ple.add(new platform(parseInt(dat.substring(x+1, x+4)), parseInt(dat.substring(x+4, x+7)), parseInt(dat.substring(x+7, x+10))));
      
    }
  }
}
void mousePressed(){
  mp=true;
  if(keyPressed&&key=='p'){
    px=mouseX;
    py=mouseY;
    platform=true;
  }
  if(keyPressed&&key=='e'){
    px=mouseX;
    py=mouseY;
    enemy=true;
  }
}
void mouseReleased(){
  if(platform){
    platform=false;
    ple.add(new platform(px, py, mouseX-px));
  }
  if(enemy){
    enemy=false;
    ple.add(new enemy(px, py, mouseX-px));
  }
  mr=true;
}
void keyPressed(){
  if(key=='s'){
    newdata=newdata+k.id+d.id+g.id);
    for(int x=0; x<ple.size(); x++){
    newdata=newdata+(ple.get(x)).id);
    saveStrings("level"+(int)(Math.random()*999), o);
    }
  }
  }

void draw(){
  background(255);
  fill(0);
  text("Press and hold:\np to add a platform\ne to add an enemy\nr to remove something\nc to change an enemy's radius\ns to save\n\nsave level to be loaded as input.txt", 100, 100, 100, 300);
  k.render();
  d.render();
  g.render();
  if(platform){
    fill(0);
    rect(px, py, mouseX-px, 5);
  }
  if(enemy){
    stroke(#ff0000);
    line(px, py, mouseX, py);
    stroke(0);
  }
  for(int x=0; x<ple.size(); x++){
    (ple.get(x)).render();
    if(ple.get(x).rem){
    ple.remove(x);
    }
  }
  mp=false;
  mr=false;
}
void setup(){
  size(500, 500);
  frameRate(30);
  data=loadStrings("input.txt");
  parsedata(data);
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
    if(keyPressed&&key=='r'){
      rem=true;
    }
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
  if(mp&&mouseinbox(x, x+22, y, y+58)){
      onclick();
    }
    fill(#E2DDC7);
    rect(x, y, 22, 58);
    ellipse(x+15, y+58/2, 5, 5);
    id="d"+i2s(x)+i2s(y)+"999";
  }
}
class guy extends entity{
  guy(int a, int b){
    super(a, b, 999);
    id="g"+i2s(a)+i2s(b)+"999";
  }
  void render(){
    super.render();
    if(mp&&mouseinbox(x-9, x+9, y-9, y+58)){
       onclick();
    }
    fill(255);
    ellipse(x, y+9, 18, 18);
    stroke(0);
    line(x-3, y+18, x, y+34);
    line(x, y+34, x+8, y+58 );
    line(x, y+34, x-6, y+58 );
    line(x-3, y+20, x-5, y+35);
    line(x-3, y+20, x+5, y+30);
    line(x+5, y+30, x+5, y+31);
    id="g"+i2s(x)+i2s(y)+"999";
  }
}
class keey extends entity{
  keey(int a, int b){
    super(a, b, 999);
    id="k"+i2s(a)+i2s(b)+"999";
  }
  void render(){
    super.render();
    if(mp&&mouseinbox(x-6, x+20, y-6, y+6)){
     onclick();
    }
      fill(#E2DDC7); 
      rect(x+16, y-2, 2, 8);
      rect(x+12, y-2, 2, 8);
      rect(x, y-2, 20, 4);
      ellipse(x, y, 12, 12);
      id="k"+i2s(x)+i2s(y)+"999";
  }
}
class platform extends entity{
  platform(int a, int b, int c){
    super(a, b, c);
    id="p"+i2s(a)+i2s(b)+i2s(c);
  }
  void render(){
    super.render();
    if(mp&&mouseinbox(x, x+w, y, y+5)){
     onclick();
   }
    fill(#003D21);
    rect(x, y, w, 5);
    id="p"+i2s(x)+i2s(y)+i2s(w);
  }
}


class enemy extends entity{
  int theta=0; 
  boolean changerad=false;
  enemy(int a, int b, int c){
    super(a, b, c);
    id="e"+i2s(a)+i2s(b)+i2s(c);
  }
  void render(){
    super.render();
    if(mousePressed&&mouseinbox(x, x+w, y, y+5)){
      onclick();
      if(keyPressed&&key=='c'){
        changerad=true;
        m=false;
    }
    }
    
    stroke(#ff0000);
    line(x, y, x+w, y);
    stroke(0);
    if(changerad){
      w=mouseX-x;
      if(mr){
      changerad=false;
      }
    }
    fill(#A2B5AE);
    ellipse(x+w*cos(radians(theta)), y+w*sin(radians(theta)), 40+random(4), 40+random(4));
    line(x+w*cos(radians(theta))-10, y+w*sin(radians(theta))+12, x+w*cos(radians(theta))-5, y+w*sin(radians(theta))+10);
    line(x+w*cos(radians(theta)), y+w*sin(radians(theta))+12, x+w*cos(radians(theta))-5, y+w*sin(radians(theta))+10);
    line(x+w*cos(radians(theta))+5, y+w*sin(radians(theta))+10, x+w*cos(radians(theta)), y+w*sin(radians(theta))+12);
    line(x+w*cos(radians(theta))+5, y+w*sin(radians(theta))+10, x+w*cos(radians(theta))+10, y+w*sin(radians(theta))+12);
    fill(0);
    ellipse(x+w*cos(radians(theta))-5, y+w*sin(radians(theta))-5, random(4), random(4));
    ellipse(x+w*cos(radians(theta))+5, y+w*sin(radians(theta))-5, random(4), random(4));
    theta++;
    id="e"+i2s(x)+i2s(y)+i2s(w);
  }
}

boolean mouseinbox(float xi, float xa, float yi, float ya){
  return (mouseX>xi&&mouseX<xa&&mouseY>yi&&mouseY<ya);
}
