import 'package:flutter/material.dart';
import 'package:autosms/components/style_button.dart';
import 'package:autosms/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sms_page.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Colors.indigo,
      body: (
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 300.0,

                    child: Image.asset('images/logayn.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter your email'),

              ),
              SizedBox(
                height: 8.0,
              ),
              new TextField(

                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              ButtonStyle(
                title: 'Log In',
                colour: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, SmsPage.id);
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),

            ],
          ),
        )
      ),
    );
  }
}