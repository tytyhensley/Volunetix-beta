import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/components/eventbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stopwatch/components/eventpasswordbox.dart';
import 'package:stopwatch/screens/charity/addVolunteer.dart';
import 'package:stopwatch/screens/charity/live_eventPage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignInVolunteer extends StatefulWidget {
  final String name;

  SignInVolunteer({this.name});

  @override
  _SignInVolunteerState createState() => _SignInVolunteerState();
}

class _SignInVolunteerState extends State<SignInVolunteer> {
  final email = TextEditingController();
  final pword = TextEditingController();
  List<String> errors;
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final DatabaseReference _getdatabase =
      FirebaseDatabase.instance.reference().child('Charities');
  final DatabaseReference _updateEvent =
      FirebaseDatabase.instance.reference().child('Events');
  final DatabaseReference _updatevolunteers =
      FirebaseDatabase.instance.reference().child('Volunteers');
  String oemail;
  String opass;
  String ouid;
  String vname;
  String vnum;

  checkTextFieldEmptyOrNot() {
    String text1, text2;

    text1 = email.text;
    text2 = pword.text;

    if (text1 == '' || text2 == '') {
      return false;
    } else {
      return true;
    }
  }

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
        _getdatabase.child(loggedInUser.uid).once().then((value) {
          var data = value.value;
          opass = data['password'];
          oemail = loggedInUser.email;
          ouid = loggedInUser.uid;
        });
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
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Text(
                    'Volunteer Sign In',
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              EventBox(
                hint: 'Email',
                keybrd: TextInputType.text,
                lines: 1,
                myController: email,
              ),
              SizedBox(
                height: 15.0,
              ),
              EventPasswordBox(
                hint: 'Password',
                keybrd: TextInputType.text,
                lines: 1,
                myController: pword,
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: GestureDetector(
                  child: Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    if (checkTextFieldEmptyOrNot() == true) {
                      try {
                        await _auth.signOut().then((value) async {
                          await _auth
                              .signInWithEmailAndPassword(
                                  email: email.text, password: pword.text)
                              .then((value) async {
                            try {
                              await _auth.currentUser().then((value) {
                                loggedInUser = value;
                                _updatevolunteers
                                    .child(loggedInUser.uid)
                                    .once()
                                    .then((value) {
                                  var data = value.value;
                                  vname = data['name'];
                                  vnum = data['number'];
                                }).then((value) {
                                  print(vname);
                                  print(vnum);
                                  _getdatabase
                                      .child(ouid)
                                      .child('list_of_events')
                                      .child(widget.name)
                                      .child('volunteers')
                                      .child(loggedInUser.uid)
                                      .set({
                                    'email': email.text,
                                    'name': vname,
                                    'number': vnum,
                                    'event': widget.name,
                                  });
                                  _updateEvent
                                      .child(widget.name)
                                      .child('volunteers')
                                      .child(loggedInUser.uid)
                                      .set({
                                    'email': email.text,
                                    'name': vname,
                                    'number': vnum,
                                    'event': widget.name,
                                  });
                                  _updatevolunteers
                                      .child(loggedInUser.uid)
                                      .child('lifelong_events_attended')
                                      .child(widget.name)
                                      .set({
                                    'email': email.text,
                                    'name': vname,
                                    'number': vnum,
                                    'event': widget.name,
                                  });
                                });
                              });
                            } catch (e) {
                              print(e);
                            }
                            await _auth.signOut().then((value) async {
                              print(oemail);
                              print(opass);
                              await _auth
                                  .signInWithEmailAndPassword(
                                      email: oemail, password: opass)
                                  .then((value) {
                                setState(() {
                                  showSpinner = false;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LiveEventPage(
                                      name: widget.name,
                                    ),
                                  ),
                                );
                              });
                            });
                          });
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
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: GestureDetector(
                  child: Text(
                    'New to Glimpse? Sign Up!',
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddVolunteer(
                          name: widget.name,
                        ),
                      ),
                    );
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
