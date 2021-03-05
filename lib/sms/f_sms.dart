import 'package:sms/sms.dart';

import 'file:///G:/app%20dev%20projects/focus_1/lib/TTS/text_to_speech.dart';

class Sms {
  SmsSender sender = new SmsSender();
  SmsReceiver receiver = new SmsReceiver();
  SmsQuery query = new SmsQuery();

  // List messages = new List();

  sendSMS(address, senderName, userName, task) async {
    //the message goes here...
    sender.sendSms(new SmsMessage(
        address,
        "Hey! $senderName , $userName is $task ."
        "He will call you back after some time. :) \n If its urgent type: Urgent \n -Focus(Ash)",
        read: true));

    print(address);
    print(senderName);

    receiver.onSmsReceived.listen((SmsMessage msg) {
      if (msg.body.toLowerCase() == "urgent") {
        say(senderName, " is saying its urgent");

        sender.sendSms(new SmsMessage(
            address,
            "Ok $senderName , $userName is saying he will call you in 5 minutes."
            "\n-Focus(Ash)",
            read: true));
      }
      print(msg.body);
    });
    //receiving sms part to be continued......
  }
}
