import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';

class CharityEventPage extends StatefulWidget {
  @override
  _CharityEventPageState createState() => _CharityEventPageState();
}

class _CharityEventPageState extends State<CharityEventPage> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: double.infinity,
            height: 50.0,
            color: Color(0xFFefeff4),
            child: Text(
              'Knowledge is Gold. Become Empowered',
              textAlign: TextAlign.center,
              style: kAppTextStyle.copyWith(
                color: ktextColorD,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                'charityevent_list',
              );
            },
            child: Image.asset(
              'assets/images/listOfEvents@2x.png',
              scale: 2.5,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                'create_event1',
              );
            },
            child: Image.asset(
              'assets/images/createEvent@2x.png',
              scale: 2.5,
            ),
          ),
        ],
      ),
    );
  }
}
