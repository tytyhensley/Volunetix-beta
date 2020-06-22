import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stopwatch/screens/charity/live_eventPage.dart';

class CreateEvent3 extends StatefulWidget {
  final String name;
  final String des;
  final List<String> tasks;

  CreateEvent3({this.name, this.des, this.tasks});
  @override
  _CreateEvent3State createState() => _CreateEvent3State();
}

class _CreateEvent3State extends State<CreateEvent3> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  UserUpdateInfo updateInfo = UserUpdateInfo();
  final DatabaseReference _getdatabase =
      FirebaseDatabase.instance.reference().child('Charities');
  final DatabaseReference _updateEvent =
      FirebaseDatabase.instance.reference().child('Events');

  String oname;
  var currDt = DateTime.now();

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
          oname = data['organization'];
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              "Congratulations! You've added an event to Volunetix!",
              textAlign: TextAlign.center,
              style: kTitleTextStyle.copyWith(
                color: ktextColorD,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Now, let's clock-in your volunteers",
              textAlign: TextAlign.center,
              style: kAppTextStyle.copyWith(
                color: ktextColorD,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              child: Container(
                color: ktextColorD,
                width: double.infinity,
                child: Text(
                  'Continue',
                  textAlign: TextAlign.center,
                  style: kAppTextStyle.copyWith(
                    fontSize: 20.0,
                    color: ktextColorA,
                  ),
                ),
              ),
              onTap: () {
                _getdatabase
                    .child(loggedInUser.uid)
                    .child('list_of_events')
                    .child(widget.name)
                    .set({
                  'charity_name': oname,
                  'clock_in': currDt.toString(),
                  'date': currDt.month.toString() +
                      '-' +
                      currDt.day.toString() +
                      '-' +
                      currDt.year.toString(),
                  'description': widget.des,
                  'event': widget.name,
                  'host': loggedInUser.uid,
                  'organization': oname,
                  'live_event': 'true',
                  'tasks': widget.tasks,
                  'total_volunteer_time': 0,
                });
                _updateEvent.child(widget.name).set({
                  'charity_name': oname,
                  'clock_in': currDt.toString(),
                  'date': currDt.month.toString() +
                      '-' +
                      currDt.day.toString() +
                      '-' +
                      currDt.year.toString(),
                  'description': widget.des,
                  'event': widget.name,
                  'host': loggedInUser.uid,
                  'organization': oname,
                  'live_event': 'true',
                  'tasks': widget.tasks,
                  'total_volunteer_time': 0,
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LiveEventPage(
                      name: widget.name,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
