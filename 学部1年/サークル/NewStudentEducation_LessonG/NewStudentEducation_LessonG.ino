//読み取ったデータ格納用の変数を予め用意
String data;

void setup() {
  //USBシリアル通信を115200bpsで初期化
  Serial.begin(9600); 
  pinMode(0,OUTPUT);
  //digitalWrite(0,HIGH);
}

void loop() {
//シリアルポートにデータが送られてきたときにボード上のLEDを点滅させる
 if(Serial.available()){
  data = Serial.readStringUntil('\n');
  if(data=="on"){
    digitalWrite(0,HIGH);
  }
  else if(data=="off"){
    digitalWrite(0,LOW);
  }
  else{
    Serial.println("Undefined Message");
  }
 }
}