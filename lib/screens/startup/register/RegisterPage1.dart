import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stopwatch/components/gradientBackground.dart';
import 'package:stopwatch/components/textbox.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/screens/startup/register/RegisterPage2.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final fname = TextEditingController();
  final lname = TextEditingController();
  final prof = TextEditingController();

  checkTextFieldEmptyOrNot() {
    String text1, text2, text3;

    text1 = fname.text;
    text2 = lname.text;
    text3 = prof.text;

    if (text1 == '' || text2 == '' || text3 == '') {
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
                'Lets get to know each other',
                style: kAppTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'What should we call you',
                style: kTitleTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextBox(
                label: 'FIRST NAME*',
                keybrd: TextInputType.emailAddress,
                lines: 1,
                myController: fname,
              ),
              TextBox(
                label: 'LAST NAME*',
                keybrd: TextInputType.text,
                lines: 1,
                myController: lname,
              ),
              TextBox(
                label: 'PROFESSION',
                keybrd: TextInputType.text,
                lines: 1,
                myController: prof,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen2(
                            fname: fname.text,
                            lname: lname.text,
                            prof: prof.text,
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
