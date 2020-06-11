import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stopwatch/components/constants.dart';

class MissionPage extends StatefulWidget {
  @override
  _MissionPageState createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/Volunetix-vertical-whiteBG.png',
              scale: 5,
            ),
            Text(
              'Our mission:',
              style: kAppTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              'We are changing the world by standardizing the nonprofit data collection process, and helping people make informed investments of their time, talents, and treasure.',
              style: kAppTextStyle.copyWith(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'What does that mean?',
              style: kAppTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              'We want to make volunteering worthwhile, impactful and easy for you',
              style: kAppTextStyle.copyWith(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'What does that mean to make an impact?',
              style: kAppTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              'Well, impact is defined as having a string effect on someone or something. We believe YOU have the power to make a positive impact on the world.',
              style: kAppTextStyle.copyWith(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Why is it important?',
              style: kAppTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              'Everyone has a goal to help make the world a better place. This app is your way of knowing how well you are pursuing that goal. Use (link coming soon) Hero Reports to get deeper metrics for College Applications, Community Restitution Documents, Corporate Giving Requirements, or just your personal goal tracking',
              style: kAppTextStyle.copyWith(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'Back',
                style: kAppTextStyle.copyWith(
                  color: ktextColorA,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
