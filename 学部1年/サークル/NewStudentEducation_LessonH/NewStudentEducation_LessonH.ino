string data1;
void setup() {
  // put your setup code here, to run once:
  Serial1.begin(115200); //UART0をボーレート:115200bpsで初期化
  //pinMode(2,INPUT); //GP02を入力ピンとして初期化
}

void loop() {
  // put your main code here, to run repeatedly:
  //if(digitalRead(2) == HIGH){ //GP02がHIGHになったら = スイッチが押されたら
    //Serial1.println('o'); //'o'という文字をUART0で送信
  //}
  if(Serial.available()){
    data1 = Serial.readStringUntil('\n'); //読み込んだ文字列を格納する
    Serial.println(data1); //PCからラズピコに文字列を送信するorラズピコからPCに文字列を送信する
  }
}


char data2; //データ格納用の変数を準備

void setup() {
  // put your setup code here, to run once:
  Serial1.begin(115200); //UART0をボーレート:115200bpsで初期化
  //pinMode(2,OUTPUT); //GP02を出力ピンとして初期化
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial1.available()){ //UART0でデータを受信したら
    data2 = Serial1.read(); //受信したデータをdataに格納
    //if(data2 == 'o'){ //そのデータが'o'ならば
      //digitalWrite(2,HIGH); //LEDを1回点滅
      //delay(500);
      //digitalWrite(2,LOW);
      //delay(500);
      Serial.println(data2);
    }
  }
}