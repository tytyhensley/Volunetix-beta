import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stopwatch/components/gradientBackground.dart';
import 'package:stopwatch/components/passwordbox.dart';
import 'package:stopwatch/components/textbox.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/screens/register/RegisterPage3.dart';

class RegistrationScreen2 extends StatefulWidget {
  final String fname;
  final String lname;
  final String prof;

  RegistrationScreen2({this.fname, this.lname, this.prof});

  @override
  _RegistrationScreen2State createState() => _RegistrationScreen2State();
}

class _RegistrationScreen2State extends State<RegistrationScreen2> {
  final _auth = FirebaseAuth.instance;

  final email = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();

  checkTextFieldEmptyOrNot() {
    String text1, text2, text3;

    text1 = email.text;
    text2 = password.text;
    text3 = cpassword.text;

    if (text1 == '' || text2 == '' || text3 == '') {
      return false;
    } else {
      return true;
    }
  }

  checkPasswordSame() {
    String text1, text2;

    text1 = password.text;
    text2 = cpassword.text;

    if (text1 == text2) {
      return true;
    } else {
      return false;
    }
  }

  createUser() {
    String usere, userp;

    usere = email.text;
    userp = password.text;

    return _auth.createUserWithEmailAndPassword(email: usere, password: userp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        child: SingleChildScrollView(
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
                height: 60.0,
              ),
              Text(
                'Its great to have you',
                style: kAppTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              RichText(
                text: TextSpan(
                  text: 'Only',
                  style: kTitleTextStyle.copyWith(
                    fontSize: 24.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' YOU',
                      style: kTitleTextStyle.copyWith(
                        fontSize: 24.0,
                        color: Colors.amber,
                      ),
                    ),
                    TextSpan(
                      text: ' can tell your story',
                      style: kTitleTextStyle.copyWith(
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextBox(
                label: 'EMAIL',
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
              PasswordTextBox(
                label: 'CONFIRM PASSWORD',
                keybrd: TextInputType.visiblePassword,
                lines: 1,
                myController: cpassword,
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
                    if (checkPasswordSame() == true) {
                      if (checkTextFieldEmptyOrNot() == true) {
                        try {
                          await createUser();
                        } catch (e) {
                          print(e);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationScreen3(
                              fname: widget.fname,
                              lname: widget.lname,
                              prof: widget.prof,
                              email: email.text,
                            ),
                          ),
                        );
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
                              "Passwords don't match",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}