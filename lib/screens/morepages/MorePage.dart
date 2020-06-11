import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainMore extends StatefulWidget {
  @override
  _MainMoreState createState() => _MainMoreState();
}

class _MainMoreState extends State<MainMore> {
  final _auth = FirebaseAuth.instance;

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
        width: double.infinity,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'mission_page');
              },
              child: Text(
                'Volunetix Mission',
                style: kAppTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'connect_page');
              },
              child: Text(
                'Stay Connected',
                style: kAppTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              child: Text(
                'QR Code',
                style: kAppTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () async {
                await _auth.signOut().then((value) {
                  Navigator.pushNamed(context, 'welcome_screen');
                });
              },
              child: Text(
                'Logout',
                style: kAppTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
