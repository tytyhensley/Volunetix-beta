import 'dart:async';
import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../components/watchbuttons.dart';
import '../components/circletime.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StopWatch extends StatefulWidget {
  final String docid;
  StopWatch({this.docid});

  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  final _firestore = Firestore.instance;

  var startcolor = ktextColorD;
  var stopcolor = ktextColorD;
  var resetcolor = ktextColorD;
  var swatch = Stopwatch();
  bool startpressed = true;
  bool stoppressed = true;
  bool resetpressed = true;
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
      resetpressed = true;
      startcolor = ktextColorA;
      stopcolor = ktextColorD;
      resetcolor = ktextColorD;
    });
    swatch.start();
    starttimer();
  }

  void stopwatch() {
    setState(() {
      stoppressed = true;
      startpressed = true;
      resetpressed = false;
      startcolor = ktextColorD;
      stopcolor = ktextColorA;
      resetcolor = ktextColorD;
    });
    swatch.stop();
    _firestore.collection('events').document(widget.docid).updateData({
      'event_timetaken': timedisplay,
    });
  }

  void resetwatch() {
    setState(() {
      stoppressed = true;
      startpressed = true;
      resetpressed = true;
      startcolor = ktextColorD;
      stopcolor = ktextColorD;
      resetcolor = ktextColorA;
    });
    swatch.reset();
    timedisplay = "00:00:00";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Event',
          style: kAppTextStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: CircleTime(timedisplay: timedisplay),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              WatchButton(
                  buttontitle: 'CLOCK-IN',
                  onTap: () {
                    if (startpressed == true) {
                      startwatch();
                    }
                  },
                  textcolor: startcolor),
              WatchButton(
                buttontitle: 'CLOCK-OUT',
                onTap: () {
                  if (stoppressed == false) {
                    stopwatch();
                  }
                },
                textcolor: stopcolor,
              ),
            ],
          ),
          WatchButton(
            buttontitle: 'RESET',
            onTap: () {
              if (resetpressed == false) {
                resetwatch();
              }
            },
            textcolor: resetcolor,
          ),
          SizedBox(
            height: 60.0,
          ),
        ],
      ),
    );
  }
}
