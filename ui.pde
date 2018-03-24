import processing.serial.*;
Serial myPort;
String gearStatus="Gear: N";

boolean straight = true;
boolean left = false;
boolean right = false;

boolean draw_gear1 = false;
boolean draw_gear2 = false;
boolean draw_gear3 = false;
boolean draw_gear4 = false;
boolean draw_gear5 = false;
boolean draw_neutral = true;
boolean draw_reverse = false;

boolean gaborite = true;
boolean nucinkisite = true;
boolean durranium = true;
boolean brookesite = true;
boolean cheungtium = true;
boolean yeatmanine = true;
  
PImage steering_wheel;
PImage neutral;
PImage reverse;
PImage gear1;
PImage gear2;
PImage gear3;
PImage gear4;
PImage gear5;

int gear = 1;
float rotation = 0;

void setup(){
  size(640, 640);
  myPort = new Serial(this, "COM6", 9600);
  myPort.bufferUntil('\n');
  neutral = loadImage("neutral.png");
  gear1 = loadImage("gear1.png");
  gear2 = loadImage("gear2.png");
  gear3 = loadImage("gear3.png");
  gear4 = loadImage("gear4.png");
  gear5 = loadImage("gear5.png");
  reverse = loadImage("reverse.png");
  steering_wheel = loadImage("wheel_straight.png");
}
void serialEvent (Serial myPort){
  gearStatus = myPort.readStringUntil('\n');
}
void draw(){
  background(237, 240, 241);
  fill(20, 160, 133);
  stroke(33);
  strokeWeight(1);
  textSize(24);
  fill(33);
  text(gearStatus, 460, 600);
  imageMode(CENTER);
  if(draw_neutral){
    image(neutral, 500, 500, 150, 150);
  }else if(draw_gear1){
    image(gear1, 500, 500, 150, 150);
  }else if(draw_gear2){
    image(gear2, 500, 500, 150, 150);
  }else if(draw_gear3){
    image(gear3, 500, 500, 150, 150);
  }else if(draw_gear4){
    image(gear4, 500, 500, 150, 150);
  }else if(draw_gear5){
    image(gear5, 500, 500, 150, 150);
  }else if(draw_reverse){
    image(reverse, 500, 500, 150, 150);
  }
   
  textSize(18);
  if(gaborite){
    text("Gaborite detected", 10, 30);
  }
  if(nucinkisite){
    text("Nucinkisite detected", 10, 50);
  }
  if(durranium){
    text("Durranium detected", 10, 70);
  }
  if(brookesite){
    text("Brookesite detected", 450, 30);
  }
  if(cheungtium){
    text("Cheungtium detected", 450, 50);
  }
  if(yeatmanine){
    text("Yeatmanine detected", 450, 70);
  }
  
  
  translate(width/2, height/2);
  if(right){
    if(rotation < PI){
      rotation+=PI/50;
    }else if (rotation >= PI){
      rotation=PI;
    }
  }else if(left){
    if(rotation > -PI){
      rotation-=PI/50;
    }else if (rotation <= -PI){
      rotation=-PI;
    }
  }else if(straight){
    if(rotation < 0){
      rotation+=PI/20;
        if(rotation > 0){
          rotation = 0;
        }
    }else if(rotation > 0){
      rotation-=PI/20;
        if(rotation < 0){
          rotation = 0;
        }
    }  
  }
  
  rotate(rotation);
  image(steering_wheel, 0, 0, 250, 250);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
        myPort.write('2');
        if(gear == 1){
          draw_gear1 = true;
        }else if(gear == 2){
          draw_gear2 = true;
        }else if(gear == 3){
          draw_gear3 = true;
        }else if(gear == 4){
          draw_gear4 = true;
        }else if(gear == 5){
          draw_gear5 = true;
        }
        draw_neutral = false;
        draw_reverse = false;
    } else if (keyCode == DOWN) {
      myPort.write('1');
      draw_neutral = false;
      draw_reverse = true;
      draw_gear1 = false;
      draw_gear2 = false;
      draw_gear3 = false;
      draw_gear4 = false;
      draw_gear5 = false;
    } else if (keyCode == RIGHT){
      myPort.write('3');
      draw_neutral = false;
      draw_reverse = false;
      right = true;
      straight = false;
      if(gear == 1){
          draw_gear1 = true;
        }else if(gear == 2){
          draw_gear2 = true;
        }else if(gear == 3){
          draw_gear3 = true;
        }else if(gear == 4){
          draw_gear4 = true;
        }else if(gear == 5){
          draw_gear5 = true;
        }
    } else if (keyCode == LEFT){
      myPort.write('4');
      left = true;
      draw_neutral = false;
      draw_reverse = false;
      straight = false;
      if(gear == 1){
        draw_gear1 = true;
      }else if(gear == 2){
        draw_gear2 = true;
      }else if(gear == 3){
        draw_gear3 = true;
      }else if(gear == 4){
        draw_gear4 = true;
      }else if(gear == 5){
        draw_gear5 = true;
      }
    }
  } else if (key == ' '){
      myPort.write('5');
      draw_neutral = true;
      draw_gear1 = false;
      draw_gear2 = false;
      draw_gear3 = false;
      draw_gear4 = false;
      draw_gear5 = false;
      draw_reverse = false;
      left = true;
  } else if (key == '1'){
      myPort.write('6');
      gear = 1;
  } else if (key == '2'){
      myPort.write('7');
      gear = 2;
  } else if (key == '3'){
      myPort.write('8');
      gear = 3;
  } else if (key == '4'){
      myPort.write('9');
      gear = 4;
      draw_reverse = false;
  } else if (key == '5'){
      myPort.write('~');
      gear = 5;
  }
}

void keyReleased() {
    myPort.write('0');
    draw_neutral = true;
    straight = true;
    draw_gear1 = false;
    draw_gear2 = false;
    draw_gear3 = false;
    draw_gear4 = false;
    draw_gear5 = false;
    draw_reverse = false;
    left = false;
    right = false;
}
