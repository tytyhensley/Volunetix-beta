import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stopwatch/components/gradientBackground.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stopwatch/screens/morepages/MorePage.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  bool showSpinner = true;
  int _currentIndex = 0;
  int _pageIndex = 0;
  final List<Widget> pages = [
    GradientBackground(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    MainMore(),
  ];

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
        setState(() {
          showSpinner = false;
        });
      }
    } catch (e) {}
  }

  Widget correctPage() {
//   correctIndex();
    return pages[_pageIndex];
  }
//
//  correctIndex() async {
//    final _userData = await _firestore
//        .collection('Volunetix')
//        .document(loggedInUser.email)
//        .get();
//    if (_userData.data['vol/org'].toString() == 'vol') {
//      if (_currentIndex != 3) {
//        setState(() {
//          _pageIndex = _currentIndex + 4;
//        });
//      } else {
//        setState(() {
//          _pageIndex = _currentIndex;
//        });
//      }
//    }
//    if (_userData.data['vol/org'].toString() == 'org') {
//      setState(() {
//        _pageIndex = _currentIndex + 1;
//      });
//    }
//  }

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
            //_currentIndex = index;
            _pageIndex = 1; //delete later, just to avoid error
          });
        },
      ),
    );
  }
}
