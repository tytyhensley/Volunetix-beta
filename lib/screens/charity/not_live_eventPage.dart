import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stopwatch/screens/charity/currentVolunteers.dart';

class NotLiveEventPage extends StatefulWidget {
  final String name;

  NotLiveEventPage({this.name});

  @override
  _NotLiveEventPageState createState() => _NotLiveEventPageState();
}

class _NotLiveEventPageState extends State<NotLiveEventPage> {
  final DatabaseReference _checkEvent =
      FirebaseDatabase.instance.reference().child('Events');

  bool showSpinner = false;
  int vol = 0;
  var totaltime = 0;
  int volHrs = 0;
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String _todaysDate() {
    var currDt = DateTime.now();
    String date = months[currDt.month - 1] +
        ' ' +
        currDt.day.toString() +
        ', ' +
        currDt.year.toString();
    return date;
  }

  @override
  void initState() {
    super.initState();
    checkEvent();
  }

  void checkEvent() {
    _checkEvent.child(widget.name).once().then((value) {
      var data = value.value;
      totaltime = data['total_time'];
      volHrs = data['total_volunteer_time'];
      data.keys.forEach((k) => {
            if (k == 'volunteers')
              {
                showSpinner = true,
                _checkEvent
                    .child(widget.name)
                    .child('volunteers')
                    .once()
                    .then((value) {
                  var voldata = value.value;
                  vol = voldata.keys.length;
                  setState(() {
                    showSpinner = false;
                  });
                })
              }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'nav_screen',
                    );
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: Text(
                    _todaysDate(),
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    widget.name,
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    '$vol Volunteers',
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (vol > 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CurrentVolunteer(
                              name: widget.name,
                              vol: vol,
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: Text(
                                "Uh-Oh",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                'This event had no volunteers',
                                textAlign: TextAlign.center,
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Image.asset(
                      'assets/images/currentvolunteers.png',
                      scale: 1.9,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: Text(
                    'This event has $volHrs volunteer minutes',
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    (totaltime != null)
                        ? 'This event lasted $totaltime minutes'
                        : 'This event lasted 0 minutes',
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
