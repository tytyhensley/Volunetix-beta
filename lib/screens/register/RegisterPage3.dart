import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stopwatch/components/gradientBackground.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/screens/register/OrganizationPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen3 extends StatefulWidget {
  final String fname;
  final String lname;
  final String prof;
  final String email;

  RegistrationScreen3({this.fname, this.lname, this.prof, this.email});

  @override
  _RegistrationScreen3State createState() => _RegistrationScreen3State();
}

class _RegistrationScreen3State extends State<RegistrationScreen3> {
  bool vol = false;
  bool org = false;

  var vcolor = Color(0xFFFFFFFF);
  var ocolor = Color(0xFFFFFFFF);

  final _firestore = Firestore.instance;

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
                'Thank you. We promise to never spam your inbox',
                style: kAppTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'So, how are you going to make a change?',
                style: kTitleTextStyle.copyWith(
                  fontSize: 25.0,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Center(
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/soloIcon.png',
                    color: vcolor,
                  ),
                  onTap: () {
                    setState(() {
                      vcolor = ktextColorA;
                      ocolor = Color(0x20FFFFFF);
                      vol = true;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/charityIcon.png',
                    color: ocolor,
                  ),
                  onTap: () {
                    setState(() {
                      ocolor = ktextColorA;
                      vcolor = Color(0x20FFFFFF);
                      org = true;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 30.0,
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
                    if (vol == true || org == true) {
                      if (vol == true) {
                        _firestore
                            .collection('Volunetix')
                            .document(widget.email)
                            .setData({
                          'first name': widget.fname,
                          'last name': widget.lname,
                          'profession': widget.prof,
                          'vol/org': 'vol',
                        });
                        Navigator.pushNamed(context, 'event_screen');
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrganizationPage(
                              fname: widget.fname,
                              lname: widget.lname,
                              prof: widget.prof,
                              email: widget.email,
                            ),
                          ),
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
                              "Please choose an option",
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
