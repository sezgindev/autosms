import 'package:autosms/scripts/sms_info.dart';

import 'screens/login_page.dart';
import 'screens/sms_page.dart';
import 'package:autosms/screens/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:autosms/screens/login_page.dart';
import 'package:autosms/screens/registration_screen.dart';
import 'package:autosms/screens/sms_page.dart';
import 'package:background_fetch/background_fetch.dart';


//uygulama sonlanınca çalışır

void main() {

  runApp(MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}


class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',

      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
     ),

    initialRoute: FirstPage.id, //ilk açılacak ekran
      routes: {
        FirstPage.id: (context) => FirstPage(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        SmsPage.id: (context) => SmsPage(),
      },
    );
  }
}
