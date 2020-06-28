import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stopwatch/components/gradientBackground.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stopwatch/screens/charity/charityEvent.dart';
import 'package:stopwatch/screens/charity/upcomingEvents/upcomingEvents1.dart';
import 'package:stopwatch/screens/morepages/MorePage.dart';
import 'package:stopwatch/screens/profile/charprofilePage.dart';
import 'package:stopwatch/screens/profile/volprofilePage.dart';
import 'package:stopwatch/screens/volunteer/eventList.dart';
import 'package:stopwatch/screens/volunteer/noeventList.dart';
import 'package:stopwatch/screens/volunteer/upcomingEvent.dart';
import 'package:firebase_database/firebase_database.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final DatabaseReference _updateVolunteer =
      FirebaseDatabase.instance.reference().child('Volunteers');
  bool showSpinner = true;
  int _currentIndex = 0;
  int _pageIndex = 0;
  var data;

  final List<Widget> pages = [
    GradientBackground(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    CharityEventPage(),
    UpcomingEvent1(),
    CharityProfilePage(),
    MainMore(),
    VolunteerEventList(),
    NoEventPage(),
    VolunteerUpcomingEvent(),
    VolunteerProfilePage(),
  ];

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
        _updateVolunteer.child(loggedInUser.uid).once().then((value) {
          data = value.value;
          setState(() {
            showSpinner = false;
          });
        });
      });
    } catch (e) {}
  }

  Widget correctPage() {
    correctIndex();
    return pages[_pageIndex];
  }

  correctIndex() async {
    if (loggedInUser.displayName == 'Volunteer') {
      if (_currentIndex != 3) {
        if (_currentIndex == 0) {
          if (data['currently_volunteering'] == 'false') {
            setState(() {
              _pageIndex = 5;
            });
          } else {
            setState(() {
              _pageIndex = 6;
            });
          }
        } else {
          setState(() {
            _pageIndex = _currentIndex + 6;
          });
        }
      } else {
        setState(() {
          _pageIndex = _currentIndex + 1;
        });
      }
    }
    if (loggedInUser.displayName == 'Charity') {
      setState(() {
        _pageIndex = _currentIndex + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: correctPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ktextColorD,
        selectedItemColor: ktextColorA,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            title: Text(
              'Events',
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pages),
            title: Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.thLarge),
            title: Text(
              'More',
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
