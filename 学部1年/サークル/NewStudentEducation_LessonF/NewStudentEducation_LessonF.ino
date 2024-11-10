const int ledPin = 0;
const int analogPin = 28;
int val = 0;
void setup() {
  // put your setup code here, to run once:
  analogReadResolution(12);
  pinMode(0,OUTPUT);
  pinMode(28,INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  val=analogRead(analogPin);
  analogWrite(ledPin,val/16);
}

