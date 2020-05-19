import 'package:flutter/material.dart';
import 'package:stopwatch/components/gradientBackground.dart';
import 'package:stopwatch/components/textbox.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stopwatch/screens/StopWatch.dart';
import 'dart:async';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  final textController_1 = TextEditingController();
  final textController_2 = TextEditingController();
  final textController_3 = TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

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
        textController_2.text = _date.year.toString() +
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

    text1 = textController_1.text;
    text2 = textController_2.text;
    text3 = textController_3.text;

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
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Volunetic-horizontal-white.png',
              fit: BoxFit.contain,
              height: 32,
            ),
          ],
        ),
      ),
      body: GradientBackground(
        begin: Alignment.center,
        end: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextBox(
                label: 'Event Name',
                keybrd: TextInputType.text,
                lines: 1,
                myController: textController_1,
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: IgnorePointer(
                  child: TextBox(
                    label: 'Event Date',
                    keybrd: TextInputType.datetime,
                    lines: 1,
                    myController: textController_2,
                  ),
                ),
              ),
              TextBox(
                label: 'Event Description',
                keybrd: TextInputType.text,
                lines: 6,
                myController: textController_3,
              ),
              SizedBox(
                height: 60.0,
              ),
              GestureDetector(
                child: Text(
                  'START EVENT',
                  style: kAppTextStyle.copyWith(
                    fontSize: 24.0,
                  ),
                ),
                onTap: () {
                  if (checkTextFieldEmptyOrNot() == true) {
                    _firestore
                        .collection('events')
                        .document(textController_1.text)
                        .setData({
                      'event_host': loggedInUser.email,
                      'event_name': textController_1.text,
                      'event_des': textController_3.text,
                      'event_date': _date.year.toString() +
                          '-' +
                          _date.month.toString() +
                          '-' +
                          _date.day.toString(),
                      'event_time':
                          _time.hour.toString() + ':' + _time.minute.toString(),
                      'event_timetaken': '00:00:00',
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StopWatch(
                          docid: textController_1.text,
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
            ],
          ),
        ),
      ),
    );
  }
}
