
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:autosms/scripts/sms_info.dart';
import 'package:flutter/animation.dart';


class SmsPage extends StatefulWidget {
  @override
  _SmsPageState createState() => _SmsPageState();
  String message;
  static const String id = 'sms_screen';

}
class _SmsPageState extends State<SmsPage> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  SmsPage a=new SmsPage();
  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();
  }
  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("AutoSms"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             ScaleTransition(
                scale: _animation,
                alignment: Alignment.center,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[

                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0,0.0,0.0,35.0),
                        child: Image.asset('images/autosmsico.png',
                          height: 120,
                          width: 120,),
                      ),
                    ]
                )
            ),

            new TextField(
              onChanged: (text) {
                a.message=text;
              },
              style: new TextStyle(
                  color: Colors.white
              ),
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintText: 'Please enter your message',
                  labelText: 'Your message',
                  prefixIcon: const Icon(
                    Icons.message,
                    color: Colors.green,
                  ),
                  suffixStyle: const TextStyle(color: Colors.green)),
            ),
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () {

              Alert(
                  context: context,
                  type: AlertType.success,
                  title: "Emin Misiniz?",
                  desc: "'"+a.message +"'"+" mesajı kaydedilsin mi?",
                  style: AlertStyle(
                    titleStyle: TextStyle(
                      color: Colors.white,
                    ),
                    descStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  buttons: [
                    DialogButton(
                      child: Text(
                        "İptal Et",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Color.fromRGBO(0, 179, 134, 1.0),
                    ),
                    DialogButton(
                      child: Text(
                        "Kaydet",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {

                        SmsInfo go=new SmsInfo();
                        go.SmsInfor(a.message);


                        Navigator.pop(context);
                        },
                        gradient: LinearGradient(colors: [
                        Color.fromRGBO(116, 116, 191, 1.0),
                        Color.fromRGBO(52, 138, 199, 1.0)
                      ]),
                    )
                  ],
                ).show();
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                    'Save Message',
                    style: TextStyle(fontSize: 20)
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}
