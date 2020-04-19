import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stopwatch/components/textbox.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/components/watchbuttons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
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

  loginUser() {
    String usere, userp;

    usere = email.text;
    userp = password.text;

    return _auth.signInWithEmailAndPassword(email: usere, password: userp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stopwatch',
          style: kAppTextStyle,
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                EventTextBox(
                  hint: 'Enter your email',
                  keybrd: TextInputType.emailAddress,
                  lines: 1,
                  myController: email,
                ),
                EventTextBox(
                  hint: 'Enter your password',
                  keybrd: TextInputType.visiblePassword,
                  lines: 1,
                  myController: password,
                ),
                Builder(
                  builder: (context) => WatchButton(
                    buttontitle: 'Login User',
                    onTap: () async {
                      if (checkTextFieldEmptyOrNot() == true) {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final user = await loginUser();
                        } catch (e) {
                          print(e);
                        }
                        Navigator.pushNamed(context, 'event_screen');
                        setState(() {
                          showSpinner = false;
                        });
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
        ),
      ),
    );
  }
}
