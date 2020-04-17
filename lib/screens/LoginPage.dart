import 'package:flutter/material.dart';
import 'package:stopwatch/components/textbox.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/components/watchbuttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            EventTextBox(
              hint: 'Enter your email',
              keybrd: TextInputType.text,
              lines: 1,
              myController: email,
            ),
            EventTextBox(
              hint: 'Enter your password',
              keybrd: TextInputType.text,
              lines: 1,
              myController: password,
            ),
            Builder(
              builder: (context) => WatchButton(
                buttontitle: 'Login User',
                onTap: () {
                  if (checkTextFieldEmptyOrNot() == true) {
                    Navigator.pushNamed(context, 'event_screen');
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        backgroundColor: kbuttonColor,
                        content: Text(
                          'Please fill in all the text fields',
                          style: TextStyle(
                            color: ktextColorA,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
                textcolor: ktextColorA,
              ),
            )
          ],
        ),
      ),
    );
  }
}
