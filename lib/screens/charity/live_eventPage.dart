import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/screens/charity/addVolunteer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stopwatch/screens/charity/currentVolunteers.dart';

class LiveEventPage extends StatefulWidget {
  final String name;

  LiveEventPage({this.name});

  @override
  _LiveEventPageState createState() => _LiveEventPageState();
}

class _LiveEventPageState extends State<LiveEventPage> {
  final DatabaseReference _checkEvent =
      FirebaseDatabase.instance.reference().child('Events');
  final DatabaseReference _checkCharity =
      FirebaseDatabase.instance.reference().child('Charities');

  bool showSpinner = false;
  int vol = 0;
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
                  height: 20.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddVolunteer(
                            name: widget.name,
                          ),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/addNewVolunteers@2x.png',
                      scale: 2.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
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
                                'You have no volunteers, Try adding some!',
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
                  height: 10.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      var currDt = DateTime.now();
                      _checkEvent.child(widget.name).once().then((value) {
                        var data = value.value;
                        String strDate = data['clock_in'];
                        String host = data['host'];
                        DateTime todayDate = DateTime.parse(strDate);
                        var diff = currDt.difference(todayDate).inMinutes;
                        _checkEvent.child(widget.name).update({
                          'clock_out': currDt.toString(),
                          'total_time': diff.toString(),
                          'live_event': 'false',
                        });
                        _checkCharity
                            .child(host)
                            .child('list_of_events')
                            .child(widget.name)
                            .update({
                          'clock_out': currDt.toString(),
                          'total_time': diff.toString(),
                          'live_event': 'false',
                        });
                      }).then((value) {
                        Navigator.pushNamed(
                          context,
                          'nav_screen',
                        );
                      });
                    },
                    child: Image.asset(
                      'assets/images/endEventButton@2x.png',
                      scale: 2.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
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
                    'This event is active!',
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
