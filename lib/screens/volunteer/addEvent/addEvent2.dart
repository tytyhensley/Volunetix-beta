import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stopwatch/screens/volunteer/addEvent/addEvent3.dart';

class AddEvent2 extends StatefulWidget {
  final String name;

  AddEvent2({this.name});

  @override
  _AddEvent2State createState() => _AddEvent2State();
}

class _AddEvent2State extends State<AddEvent2> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final DatabaseReference _updateVolunteer =
      FirebaseDatabase.instance.reference().child('Volunteers');
  final DatabaseReference _updateVolunteer1 =
      FirebaseDatabase.instance.reference().child('Volunteers');
  final DatabaseReference _updateEvent =
      FirebaseDatabase.instance.reference().child('Events');
  final DatabaseReference _updateCharity =
      FirebaseDatabase.instance.reference().child('Charities');

  double cIn = 1.0;
  double cOt = 1.0;
  String uid;
  DateTime currDt;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    try {
      await _auth.currentUser().then((value) {
        loggedInUser = value;
        _updateEvent.child(widget.name).once().then((value) {
          var data = value.value;
          uid = data['host'];
        });
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'nav_screen');
              },
              child: Icon(
                Icons.close,
                color: Colors.black,
                size: 14.0,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  currDt = DateTime.now();
                  setState(() {
                    cIn = 0.5;
                  });
                  _updateVolunteer
                      .child(loggedInUser.uid)
                      .child('lifelong_events_attended')
                      .child(widget.name)
                      .update({
                    'clock_in': currDt.toString(),
                  });
                  _updateEvent
                      .child(widget.name)
                      .child('volunteers')
                      .child(loggedInUser.uid)
                      .update({
                    'clock_in': currDt.toString(),
                  });
                  _updateCharity
                      .child(uid)
                      .child('list_of_events')
                      .child(widget.name)
                      .child('volunteers')
                      .child(loggedInUser.uid)
                      .update({
                    'clock_in': currDt.toString(),
                  });
                },
                child: Opacity(
                  opacity: cIn,
                  child: Image.asset(
                    'assets/images/clockIn@2x.png',
                    scale: 2.5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  currDt = DateTime.now();
                  setState(() {
                    cOt = 0.5;
                  });
                  _updateVolunteer
                      .child(loggedInUser.uid)
                      .child('lifelong_events_attended')
                      .child(widget.name)
                      .update({
                    'clock_out': currDt.toString(),
                  });
                  _updateEvent
                      .child(widget.name)
                      .child('volunteers')
                      .child(loggedInUser.uid)
                      .update({
                    'clock_out': currDt.toString(),
                  });
                  _updateCharity
                      .child(uid)
                      .child('list_of_events')
                      .child(widget.name)
                      .child('volunteers')
                      .child(loggedInUser.uid)
                      .update({
                    'clock_out': currDt.toString(),
                  });
                  _updateVolunteer1.child(loggedInUser.uid).update({
                    'currently_volunteering': 'false',
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: Text(
                          "Success!",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        content: Text(
                          "Your time has been added tot he event, Thank You! ",
                          textAlign: TextAlign.center,
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddEvent3(
                                    name: widget.name,
                                    taskslist: ['No tasks'],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Opacity(
                  opacity: cOt,
                  child: Image.asset(
                    'assets/images/clockOut@2x.png',
                    scale: 2.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
