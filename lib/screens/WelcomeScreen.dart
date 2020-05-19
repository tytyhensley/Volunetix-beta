import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/components/welcomebutton.dart';
import 'package:stopwatch/components/gradientBackground.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 70.0,
            ),
            Image.asset(
              'assets/images/Volunetix-vertical-white.png',
              height: 100,
              width: 100,
              color: ktextColorA,
            ),
            SizedBox(
              height: 60.0,
            ),
            Center(
              child: AutoSizeText(
                'Welcome to Volunetix',
                style: kTitleTextStyle,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: AutoSizeText(
                'Join our community of volunteers and charites. Lets change the world together',
                style: kAppTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            WelcomeButton(
              buttontitle: 'Sign Up with Email',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'registration_screen',
                );
              },
              textcolor: Colors.deepPurple[700],
            ),
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'login_screen',
                  );
                },
                child: Text(
                  'Already have an account? Sign In',
                  style: kAppTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
