import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stopwatch/screens/volunteer/addEvent/addEvent2.dart';

class NoEventPage extends StatefulWidget {
  @override
  _NoEventPageState createState() => _NoEventPageState();
}

class _NoEventPageState extends State<NoEventPage> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final DatabaseReference _getVolunteer =
      FirebaseDatabase.instance.reference().child('Volunteers');

  String levent;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    try {
      showSpinner = true;
      await _auth.currentUser().then((value) {
        loggedInUser = value;
        _getVolunteer.child(loggedInUser.uid).once().then((value) {
          var data = value.value;
          levent = data['last_event_attended'];
        }).then((value) {
          setState(() {
            showSpinner = false;
          });
        });
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ktextColorD,
        automaticallyImplyLeading: false,
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Time Manager',
                textAlign: TextAlign.center,
                style: kAppTextStyle.copyWith(
                  color: ktextColorD,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEvent2(
                        name: levent,
                      ),
                    ),
                  );
                },
                child: Text(
                  'You are currently volunteering at an event named: $levent',
                  textAlign: TextAlign.center,
                  style: kAppTextStyle.copyWith(
                    color: ktextColorD,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
