const int LD = 8;
const int LPWM = 9;
const int RD = 7;
const int RPWM = 6;

int velocity = 160;

int state = 0;
void setup() {
  Serial.begin(9600);
}
void loop() {
 if(Serial.available() > 0){
    state = Serial.read();
 }
 if (state == '0') {
  analogWrite(LPWM, 0);
  analogWrite(RPWM, 0);
  Serial.println("Gear: N");
  state = 0;
 } else if (state == '1') {
  // backward
  digitalWrite(LD, LOW);
  digitalWrite(RD, LOW);
  Serial.println("Gear: R");
  analogWrite(LPWM, velocity);
  analogWrite(RPWM, velocity);
  state = 0;
 } else if (state == '2'){
  // forward
  digitalWrite(LD, HIGH);
  digitalWrite(RD, HIGH);
  Serial.println("Gear: 1");;
  analogWrite(LPWM, velocity);
  analogWrite(RPWM, velocity);
  state = 0;
 } else if (state == '3'){
  //left
  digitalWrite(LD, HIGH);
  digitalWrite(RD, LOW);
  Serial.println("Gear: 1");;
  analogWrite(LPWM, velocity);
  analogWrite(RPWM, 0);
  state = 0;
 } else if (state == '4'){
  //right
  digitalWrite(LD, LOW);
  digitalWrite(RD, HIGH);
  Serial.println("Gear: 1");;
  analogWrite(LPWM, 0);
  analogWrite(RPWM, velocity);
  state = 0;
 } else if (state == '5'){
  //180
  digitalWrite(LD, LOW);
  digitalWrite(RD, HIGH);
  Serial.println("Gear: N");;
  analogWrite(LPWM, velocity);
  analogWrite(RPWM, velocity);
  state = 0;
 } else if (state == '6'){
  Serial.println("Gear: N");
  velocity = 160;
  state = 0;
 } else if (state == '7'){
  velocity = 180;
  Serial.println("Gear: N");;
  state = 0;
 } else if (state == '8'){
  velocity = 200;
  Serial.println("Gear: N");;
  state = 0;
 } else if (state == '9'){
  velocity = 220;
  Serial.println("Gear: N");;
  state = 0;
 } else if (state == '~'){
  velocity = 240;
  Serial.println("Gear: N");;
  state = 0;
 }
}
