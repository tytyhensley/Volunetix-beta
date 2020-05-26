import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stopwatch/components/gradientBackground.dart';
import 'package:stopwatch/components/passwordbox.dart';
import 'package:stopwatch/components/textbox.dart';
import 'package:stopwatch/components/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final password = TextEditingController();
  List<String> errors;

  checkTextFieldEmptyOrNot() {
    String text1, text2;

    text1 = email.text;
    text2 = password.text;
    if (text1 == '' || text2 == '') {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'Welcome back,',
              style: kAppTextStyle.copyWith(
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Sign in',
              style: kTitleTextStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextBox(
              label: 'EMAIL ADDRESS',
              keybrd: TextInputType.emailAddress,
              lines: 1,
              myController: email,
            ),
            PasswordTextBox(
              label: 'PASSWORD',
              keybrd: TextInputType.visiblePassword,
              lines: 1,
              myController: password,
            ),
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: GestureDetector(
                child: Text(
                  'Next',
                  style: kAppTextStyle.copyWith(
                    fontSize: 20.0,
                  ),
                ),
                onTap: () async {
                  if (checkTextFieldEmptyOrNot() == true) {
                    try {
                      await _auth
                          .signInWithEmailAndPassword(
                              email: email.text, password: password.text)
                          .then((value) {
                        Navigator.pushNamed(context, 'event_screen');
                      });
                    } catch (error) {
                      errors = error.toString().split(',');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: Text(
                              "Uh-Oh",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              errors[1],
                              textAlign: TextAlign.center,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: Text(
                            "Uh-Oh",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          content: Text(
                            "Please fill in all text fields",
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
