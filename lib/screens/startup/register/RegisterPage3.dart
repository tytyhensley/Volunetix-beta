import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stopwatch/components/gradientBackground.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/screens/startup/register/OrganizationPage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen3 extends StatefulWidget {
  final String fname;
  final String lname;
  final String prof;
  final String email;
  final String pnum;
  final String pass;

  RegistrationScreen3(
      {this.fname, this.lname, this.prof, this.email, this.pnum, this.pass});

  @override
  _RegistrationScreen3State createState() => _RegistrationScreen3State();
}

class _RegistrationScreen3State extends State<RegistrationScreen3> {
  bool vol = false;
  bool org = false;
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  UserUpdateInfo updateInfo = UserUpdateInfo();
  final DatabaseReference database =
      FirebaseDatabase.instance.reference().child('Volunteers');

  var vcolor = Color(0xFFFFFFFF);
  var ocolor = Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GradientBackground(
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
                        org = false;
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
                        vol = false;
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
                          updateInfo.displayName = 'Volunteer';
                          await loggedInUser.updateProfile(updateInfo);
                          setState(() {
                            showSpinner = true;
                          });
                          database.child(loggedInUser.uid).set({
                            'firstName': widget.fname,
                            'lastName': widget.lname,
                            'email': widget.email,
                            'occupation': widget.prof,
                            'number': widget.pnum,
                            'name': widget.fname + ' ' + widget.lname,
                            'signed_up_at_event': 'false',
                            'currently_volunteering': 'false',
                            'uid': loggedInUser.uid,
                            'total_career_time': 0,
                          });
                          Navigator.pushNamed(context, 'nav_screen');
                          setState(() {
                            showSpinner = false;
                          });
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrganizationPage(
                                fname: widget.fname,
                                lname: widget.lname,
                                prof: widget.prof,
                                email: widget.email,
                                pnum: widget.pnum,
                                pass: widget.pass,
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
      ),
    );
  }
}
