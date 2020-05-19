import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stopwatch/components/gradientBackground.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/components/textbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationPage extends StatefulWidget {
  final String fname;
  final String lname;
  final String prof;
  final String email;

  OrganizationPage({this.fname, this.lname, this.prof, this.email});
  @override
  _OrganizationPageState createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  final oname = TextEditingController();
  final _firestore = Firestore.instance;

  checkTextFieldEmptyOrNot() {
    String text1;

    text1 = oname.text;

    if (text1 == '') {
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
                height: 40.0,
              ),
              Text(
                'Wonderful, ',
                style: kAppTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              RichText(
                text: TextSpan(
                  text: 'Our platform will help you tell memorble stories ',
                  style: kTitleTextStyle.copyWith(
                    fontSize: 24.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'empowered',
                      style: kTitleTextStyle.copyWith(
                        fontSize: 24.0,
                        color: Colors.amber,
                      ),
                    ),
                    TextSpan(
                      text: ' with data, but whose the author',
                      style: kTitleTextStyle.copyWith(
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              TextBox(
                label: 'ORGANIZATION NAME',
                keybrd: TextInputType.text,
                lines: 1,
                myController: oname,
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
                      _firestore
                          .collection('Volunetix')
                          .document(widget.email)
                          .setData({
                        'first name': widget.fname,
                        'last name': widget.lname,
                        'profession': widget.prof,
                        'vol/org': 'org',
                      });
                      _firestore
                          .collection('Volunetix')
                          .document(widget.email)
                          .collection(oname.text);
                      Navigator.pushNamed(context, 'event_screen');
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
                              "Please enter organization name",
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
