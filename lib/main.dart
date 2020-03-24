/* This is a simple stopwatch implementation with only a start and stop button.*/

import 'dart:async';
import 'package:flutter/material.dart';

const kbuttonColor = Color(0xFF050505);
const ktextColorD = Colors.white;
const ktextColorA = Colors.deepOrangeAccent;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Color(0xFF050505),
      ),
      home: StopWatch(),
    );
  }
}

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  var starttextcolor = ktextColorD;
  var stoptextcolor = ktextColorD;
  var swatch = Stopwatch();
  bool startpressed = true;
  bool stoppressed = true;
  String timedisplay = "00:00:00";
  final dur = const Duration(seconds: 1);

  void starttimer() {
    Timer(dur, getTime);
  }

  void getTime() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      timedisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startwatch() {
    setState(() {
      stoppressed = false;
      startpressed = false;
      starttextcolor = ktextColorA;
      stoptextcolor = ktextColorD;
    });
    swatch.start();
    starttimer();
  }

  void stopwatch() {
    setState(() {
      stoppressed = true;
      startpressed = true;
      starttextcolor = ktextColorD;
      stoptextcolor = ktextColorA;
    });
    swatch.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simple Stopwatch',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 300.0,
            height: 300.0,
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              timedisplay,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  child: RaisedButton(
                    onPressed: startpressed ? startwatch : null,
                    color: kbuttonColor,
                    disabledColor: kbuttonColor,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'START',
                      style: TextStyle(
                        color: starttextcolor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  child: RaisedButton(
                    onPressed: stoppressed ? null : stopwatch,
                    color: kbuttonColor,
                    disabledColor: kbuttonColor,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'STOP',
                      style: TextStyle(
                        color: stoptextcolor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
