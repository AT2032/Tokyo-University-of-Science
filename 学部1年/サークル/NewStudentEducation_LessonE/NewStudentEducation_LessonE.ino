int val;
int old_val=LOW;
int led=LOW;
void setup() {
  // put your setup code here, to run once:
  pinMode(25,OUTPUT);
  digitalWrite(25,LOW);
  pinMode(0,INPUT);
  digitalWrite(0,LOW);
  

}

void loop() {
  // put your main code here, to run repeatedly:
  val=digitalRead(0);
  if(val !=old_val&& val==HIGH){
    led = !led;
    digitalWrite(25,led);
  }
  old_val=digitalRead(0);
  delay(100);

}