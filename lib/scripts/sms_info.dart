import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:autosms/main.dart';
import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import '../screens/sms_page.dart';

class Deneme{
  @override
  SmsReceiver(){
    print( "fffff");
  }

}

class SmsInfo{


  SmsSender sender = new SmsSender();
  SmsReceiver receiver = new SmsReceiver(); //smsreciever nesne oluÅŸtur
  SmsPage d=new SmsPage();
  String SendAdress;
  String SendMessage;


  void deneme(String dd,String mesaj){
    SendAdress=dd;
    SendMessage=mesaj;
    SmsMessage message = new SmsMessage(SendAdress,SendMessage);
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        print("SMS is sent!");
      } else if (state == SmsMessageState.Delivered) {
        print("SMS is delivered!");
      }
    });
    sender.sendSms(message); //mesaj gÃ¶nder
    print(SendAdress);
    print(SendMessage);//bunu almÄ±yo *******
  }

  SmsInfor(String mesac){

      receiver.onSmsReceived.listen((SmsMessage msg) => deneme(msg.address,mesac)); //gelen mesajlarÄ± dinle ve ekrana numarasÄ±nÄ± yaz
    }

}






