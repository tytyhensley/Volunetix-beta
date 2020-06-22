import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stopwatch/screens/charity/upcomingEvents/upcomingEvents3.dart';

class UpcomingEvent1 extends StatefulWidget {
  @override
  _UpcomingEvent1State createState() => _UpcomingEvent1State();
}

class _UpcomingEvent1State extends State<UpcomingEvent1> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

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
    } catch (e) {
      print(e);
    }
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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Lets inform volunteers of your upcoming event!",
              textAlign: TextAlign.center,
              style: kAppTextStyle.copyWith(
                color: ktextColorD,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'upcoming_event2',
                );
              },
              child: Image.asset(
                'assets/images/createEvent@2x.png',
                scale: 2.5,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpcomingEvent3(
                      uid: loggedInUser.uid,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: ktextColorA,
                  ),
                  Text(
                    "Upcoming Events",
                    textAlign: TextAlign.center,
                    style: kAppTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
