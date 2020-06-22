import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/components/eventbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UpcomingEvent2 extends StatefulWidget {
  @override
  _UpcomingEvent2State createState() => _UpcomingEvent2State();
}

class _UpcomingEvent2State extends State<UpcomingEvent2> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final DatabaseReference _getdatabase =
      FirebaseDatabase.instance.reference().child('Charities');
  final DatabaseReference _updateEvent =
      FirebaseDatabase.instance.reference().child('UpcomingEvents');

  final name = TextEditingController();
  final date = TextEditingController();
  final des = TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  String oname;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2021),
    );
    final TimeOfDay picked2 = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        _time = picked2;
        date.text = _date.year.toString() +
            '-' +
            _date.month.toString() +
            '-' +
            _date.day.toString() +
            ' ' +
            _time.hour.toString() +
            ':' +
            _time.minute.toString();
      });
    }
  }

  checkTextFieldEmptyOrNot() {
    String text1, text2, text3;

    text1 = name.text;
    text2 = date.text;
    text3 = des.text;

    if (text1 == '' || text2 == '' || text3 == '') {
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
      await _auth.currentUser().then((value) {
        loggedInUser = value;
        _getdatabase.child(loggedInUser.uid).once().then((value) {
          var data = value.value;
          oname = data['organization'].toString();
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ktextColorD,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/volunetixLogoSmall.png',
              color: Colors.white,
              fit: BoxFit.contain,
              height: 32,
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Create Your Upcoming Event',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              Text(
                'Volunteers will be able to view the event',
                textAlign: TextAlign.center,
                style: kAppTextStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Name',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              EventBox(
                keybrd: TextInputType.text,
                lines: 1,
                myController: name,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Date',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: IgnorePointer(
                  child: EventBox(
                    label: 'Event Date',
                    keybrd: TextInputType.datetime,
                    lines: 1,
                    myController: date,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Description',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              EventBox(
                keybrd: TextInputType.text,
                lines: 6,
                myController: des,
              ),
              SizedBox(
                height: 40.0,
              ),
              GestureDetector(
                child: Container(
                  color: ktextColorD,
                  width: double.infinity,
                  child: Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: kAppTextStyle.copyWith(
                      fontSize: 24.0,
                      color: ktextColorA,
                    ),
                  ),
                ),
                onTap: () {
                  if (checkTextFieldEmptyOrNot() == true) {
                    DateTime currDt = DateTime.now();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: Text(
                            "Ready To Create Post?",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          content: Text(
                            "This will be added to the Upcoming Events Board",
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text(
                                "Sumbit",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                _updateEvent.child(name.text).set({
                                  'host': loggedInUser.uid,
                                  'dateCreated': currDt.toString(),
                                  'dateOfFutureEvent': date.text,
                                  'description': des.text,
                                  'event': name.text,
                                  'organization': oname,
                                  'live_event': 'true',
                                });
                                Navigator.pushNamed(
                                  context,
                                  'nav_screen',
                                );
                              },
                            ),
                          ],
                        );
                      },
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
            ],
          ),
        ),
      ),
    );
  }
}
