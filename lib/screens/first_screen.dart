import 'package:autosms/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:autosms/screens/login_page.dart';
import 'package:background_fetch/background_fetch.dart';

var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

void backgroundFetchHeadlessTask() async {
  print('[BackgroundFetch] Headless event received.');
  BackgroundFetch.finish();
}

class FirstPage extends StatefulWidget {
  static const String id = 'first_screen';
  @override
  _FirstPageState createState() => _FirstPageState();

}
class _FirstPageState extends State<FirstPage> {

  bool _enabled = true;
  int _status = 0;
  List<DateTime> _events = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(BackgroundFetchConfig(
      minimumFetchInterval: 15,
      stopOnTerminate: false,
      enableHeadless: false,
    ), () async {
      // This is the fetch-event callback.
      print('[BackgroundFetch] Event received');
      setState(() {
        _events.insert(0, new DateTime.now());
      });
      // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
      // for taking too long in the background.
      BackgroundFetch.finish();
    }).then((int status) {
      print('[BackgroundFetch] configure success: $status');
      setState(() {
        _status = status;
      });
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
      setState(() {
        _status = e;
      });
    });

    int status = await BackgroundFetch.status;
    setState(() {
      _status = status;
    });

    if (!mounted) return;
  }


  void _onClickEnable(enabled) {
    setState(() {
      _enabled = enabled;
    });
    if (enabled) {
      BackgroundFetch.start().then((int status) {
        print('[BackgroundFetch] start success: $status');
      }).catchError((e) {
        print('[BackgroundFetch] start FAILURE: $e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("AutoSms"),
          actions: <Widget>[
            Switch(value: _enabled, onChanged: _onClickEnable),
          ]
      ),
      backgroundColor: Colors.indigo,
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom:18.0),
              child: Image.asset('images/messageico.png',
          height: 100,
          width: 100,),
            ),

          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Text("AutoSms",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30.0
                ,)),
          ),

         Padding(
           padding: const EdgeInsets.all(28.0),
           child: NiceButton(
            radius: 40,
            text: "Login",
            icon: Icons.account_circle,
            gradientColors: [secondColor, firstColor],
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
                ),
         ),


        Padding(
          padding: const EdgeInsets.only(bottom:28.0),
          child: NiceButton(
             radius: 40,
             padding: const EdgeInsets.all(15),
             text: "Register",
             icon: Icons.add_circle_outline,
             gradientColors: [secondColor, firstColor],
             onPressed: () {
               Navigator.pushNamed(context, RegistrationScreen.id);
               },
               ),
        ),

          ],
        ),
      ),
    );
  }

}
