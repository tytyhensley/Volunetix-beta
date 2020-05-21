import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/components/welcomebutton.dart';
import 'package:stopwatch/components/gradientBackground.dart';
import 'dart:math';
import 'package:animator/animator.dart';

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
              height: 50.0,
            ),
            Animator(
              tween: Tween<double>(begin: 0, end: 2 * pi),
              duration: Duration(seconds: 6),
              repeats: 0,
              builder: (_, anim, __) => Transform(
                transform: Matrix4.rotationY(anim.value),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/volunetixLogoSmall.png',
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Animator(
              duration: Duration(seconds: 1),
              builder: (_, anim, __) => Opacity(
                opacity: anim.value,
                child: Center(
                  child: AutoSizeText(
                    'Welcome to Volunetix',
                    style: kTitleTextStyle,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Animator(
              duration: Duration(seconds: 2),
              builder: (_, anim, __) => Opacity(
                opacity: anim.value,
                child: Center(
                  child: AutoSizeText(
                    'Join our community of volunteers and charites. Lets change the world together',
                    style: kAppTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Animator(
              duration: Duration(seconds: 3),
              builder: (_, anim, __) => Opacity(
                opacity: anim.value,
                child: WelcomeButton(
                  buttontitle: 'Sign Up with Email',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'registration_screen',
                    );
                  },
                  textcolor: Colors.deepPurple[700],
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Animator(
              duration: Duration(seconds: 3),
              builder: (_, anim, __) => Opacity(
                opacity: anim.value,
                child: Center(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
