import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/components/eventbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stopwatch/screens/volunteer/addEvent/addEvent4.dart';

class AddEvent3 extends StatefulWidget {
  final String name;
  final List<String> taskslist;

  AddEvent3({this.name, this.taskslist});
  @override
  _AddEvent3State createState() => _AddEvent3State();
}

class _AddEvent3State extends State<AddEvent3> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final DatabaseReference _updateVolunteer =
      FirebaseDatabase.instance.reference().child('Volunteers');
  final DatabaseReference _updateVolunteer1 =
      FirebaseDatabase.instance.reference().child('Volunteers');
  final DatabaseReference _updateEvent =
      FirebaseDatabase.instance.reference().child('Events');
  final DatabaseReference _updateEvent1 =
      FirebaseDatabase.instance.reference().child('Events');
  final DatabaseReference _updateCharity =
      FirebaseDatabase.instance.reference().child('Charities');
  final DatabaseReference _updateCharity1 =
      FirebaseDatabase.instance.reference().child('Charities');

  final tasks = TextEditingController();
  final whyVol = TextEditingController();
  final occ = TextEditingController();
  double _value = 0;
  String uid;
  String cIn;
  String cOt;
  int volhrs;
  int careerhrs;
  List<String> slider = ['No', 'Somewhat No', 'Neutral', 'Somewhat Yes', 'Yes'];

  checkTextFieldEmptyOrNot() {
    String text1, text2;

    text1 = whyVol.text;
    text2 = occ.text;

    if (text1 == '' || text2 == '' || widget.taskslist[0] == 'No tasks') {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    try {
      await _auth.currentUser().then((value) {
        loggedInUser = value;
        _updateEvent.child(widget.name).once().then((value) {
          var data = value.value;
          uid = data['host'];
          volhrs = data['total_volunteer_time'];
        });
        _updateVolunteer1.child(loggedInUser.uid).once().then((value) {
          var timedata = value.value;
          careerhrs = timedata['total_career_time'];
        });
        _updateVolunteer
            .child(loggedInUser.uid)
            .child('lifelong_events_attended')
            .child(widget.name)
            .once()
            .then((value) {
          var voldata = value.value;
          cIn = voldata['clock_in'];
          cOt = voldata['clock_out'];
        });
      });
      tasks.text = widget.taskslist.toString();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Select the tasks you completed while volunteering',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEvent4(
                        name: widget.name,
                        taskslist: widget.taskslist,
                      ),
                    ),
                  );
                },
                child: IgnorePointer(
                  child: EventBox(
                    keybrd: TextInputType.text,
                    lines: 1,
                    myController: tasks,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Why did you volunteer today?',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              EventBox(
                keybrd: TextInputType.text,
                lines: 2,
                myController: whyVol,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Did you make an impact?',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'No',
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20,
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Colors.grey,
                      inactiveTickMarkColor: Colors.grey,
                      activeTickMarkColor: ktextColorD,
                      activeTrackColor: ktextColorD,
                      overlayColor: ktextColorD.withAlpha(32),
                      trackShape: RectangularSliderTrackShape(),
                      trackHeight: 3.0,
                      thumbColor: ktextColorD,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: ktextColorD,
                      valueIndicatorTextStyle: TextStyle(
                        color: ktextColorA,
                      ),
                    ),
                    child: Slider(
                      value: _value,
                      min: 0,
                      max: 4,
                      divisions: 4,
                      label: slider[_value.toInt()],
                      onChanged: (value) {
                        setState(
                          () {
                            _value = value;
                          },
                        );
                      },
                    ),
                  ),
                  Text(
                    'Yes',
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "What's your occupation?",
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              EventBox(
                keybrd: TextInputType.text,
                lines: 2,
                myController: occ,
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    DateTime clockIn = DateTime.parse(cIn);
                    DateTime clockOut = DateTime.parse(cOt);
                    var diff = clockOut.difference(clockIn).inMinutes;
                    volhrs = diff + volhrs;
                    careerhrs = diff + careerhrs;
                    if (checkTextFieldEmptyOrNot() == true) {
                      _updateVolunteer
                          .child(loggedInUser.uid)
                          .child('lifelong_events_attended')
                          .child(widget.name)
                          .update({
                        'total_time': diff.toString(),
                        'didVolunteerMakeAnImpact':
                            slider[_value.toInt()].toString(),
                        'occupation': occ.text,
                        'tasksCompletedArray': widget.taskslist,
                        'impact_score': _value.toString(),
                        'whyDid': whyVol.text,
                      });
                      _updateEvent
                          .child(widget.name)
                          .child('volunteers')
                          .child(loggedInUser.uid)
                          .update({
                        'total_time': diff.toString(),
                        'didVolunteerMakeAnImpact':
                            slider[_value.toInt()].toString(),
                        'occupation': occ.text,
                        'tasksCompletedArray': widget.taskslist,
                        'impact_score': _value.toString(),
                        'whyDid': whyVol.text,
                      });
                      _updateCharity
                          .child(uid)
                          .child('list_of_events')
                          .child(widget.name)
                          .child('volunteers')
                          .child(loggedInUser.uid)
                          .update({
                        'total_time': diff.toString(),
                        'didVolunteerMakeAnImpact':
                            slider[_value.toInt()].toString(),
                        'occupation': occ.text,
                        'tasksCompletedArray': widget.taskslist,
                        'impact_score': _value.toString(),
                        'whyDid': whyVol.text,
                      });
                      _updateEvent1.child(widget.name).update({
                        'total_volunteer_time': volhrs,
                      });
                      _updateCharity1
                          .child(uid)
                          .child('list_of_events')
                          .child(widget.name)
                          .update({
                        'total_volunteer_time': volhrs,
                      });
                      _updateVolunteer1.child(loggedInUser.uid).update({
                        'total_career_time': careerhrs,
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: Text(
                              "Ready to Submit Survey",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              "This will added to the event, make sure its correct",
                              textAlign: TextAlign.center,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  "Sumbit",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    'nav_screen',
                                  );
                                },
                              ),
                            ],
                          );
                        },
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
                              "Please fill in all text fields",
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
                    'assets/images/submit.png',
                    scale: 2.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
