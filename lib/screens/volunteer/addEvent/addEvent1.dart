import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stopwatch/screens/volunteer/addEvent/addEvent2.dart';

class AddEvent1 extends StatefulWidget {
  final String name;

  AddEvent1({this.name});
  @override
  _AddEvent1State createState() => _AddEvent1State();
}

class _AddEvent1State extends State<AddEvent1> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final DatabaseReference _updateVolunteer =
      FirebaseDatabase.instance.reference().child('Volunteers');

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    try {
      await _auth.currentUser().then((value) {
        loggedInUser = value;
      });
    } catch (e) {}
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              'Are you Ready to Sign In',
              textAlign: TextAlign.center,
              style: kTitleTextStyle.copyWith(
                color: ktextColorD,
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            widget.name,
            textAlign: TextAlign.center,
            style: kTitleTextStyle.copyWith(
              color: ktextColorD,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          GestureDetector(
            child: Text(
              'Yes',
              textAlign: TextAlign.center,
              style: kTitleTextStyle.copyWith(
                color: ktextColorD,
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            onTap: () {
              _updateVolunteer.child(loggedInUser.uid).update({
                'currently_volunteering': 'true',
                'last_event_attended': widget.name,
              }).then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEvent2(
                      name: widget.name,
                    ),
                  ),
                );
              });
            },
          )
        ],
      ),
    );
  }
}
