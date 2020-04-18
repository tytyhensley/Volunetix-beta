import 'package:stopwatch/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/components/watchbuttons.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stopwatch',
          style: kAppTextStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          WatchButton(
            buttontitle: 'LOGIN',
            onTap: () {
              Navigator.pushNamed(
                context,
                'login_screen',
              );
            },
            textcolor: ktextColorA,
          ),
          SizedBox(
            height: 100.0,
          ),
          WatchButton(
            buttontitle: 'REGISTER',
            onTap: () {
              Navigator.pushNamed(
                context,
                'registration_screen',
              );
            },
            textcolor: ktextColorA,
          ),
        ],
      ),
    );
  }
}
