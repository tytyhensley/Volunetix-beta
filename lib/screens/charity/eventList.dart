import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stopwatch/screens/charity/live_eventPage.dart';
import 'package:stopwatch/screens/charity/not_live_eventPage.dart';

class CharityEventList extends StatefulWidget {
  @override
  _CharityEventListState createState() => _CharityEventListState();
}

class _CharityEventListState extends State<CharityEventList> {
  final DatabaseReference _checkCharities =
      FirebaseDatabase.instance.reference().child('Charities');
  final DatabaseReference _checkEvent =
      FirebaseDatabase.instance.reference().child('Events');
  final DatabaseReference _checkVolunteer =
      FirebaseDatabase.instance.reference().child('Volunteers');
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  bool showSpinner = false;

  var keyList = List();
  var data;
  var holder = 'No events';

  void _deleteEvent(String host) {
    _checkEvent.child(host).child('volunteers').once().then((value) {
      var voldata = value.value;
      if (voldata != null) {
        voldata.keys.forEach((k) => {
              _checkVolunteer
                  .child(k.toString())
                  .child('lifelong_events_attended')
                  .child(host)
                  .remove(),
            });
      }
    });
    _checkCharities.child(loggedInUser.uid)
      ..child('list_of_events').child(host).remove();
    _checkEvent.child(host).remove();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    showSpinner = true;
    try {
      await _auth.currentUser().then((value) {
        loggedInUser = value;
        _checkCharities
            .child(loggedInUser.uid)
            .child('list_of_events')
            .once()
            .then((value) {
          data = value.value;
          if (data != null) {
            data.keys.forEach((k) => {
                  keyList.add(k),
                });
          } else {
            keyList.add(holder);
          }
        }).then((value) => {
                  setState(() {
                    showSpinner = false;
                  })
                });
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ktextColorD,
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          height: double.maxFinite,
          color: Colors.white,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: keyList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    GestureDetector(
                      child: Text(
                        keyList[index].toString(),
                        style: kTitleTextStyle.copyWith(
                          color: ktextColorD,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        if (keyList[index].toString() != holder) {
                          _checkCharities
                              .child(loggedInUser.uid)
                              .child('list_of_events')
                              .child(keyList[index].toString())
                              .once()
                              .then((value) {
                            var chardata = value.value;
                            if (chardata['live_event'] == 'true') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LiveEventPage(
                                    name: keyList[index].toString(),
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotLiveEventPage(
                                    name: keyList[index].toString(),
                                  ),
                                ),
                              );
                            }
                          });
                        }
                      },
                      onLongPress: () {
                        if (keyList[index].toString() != holder) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: Text(
                                  "Warning",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.red,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(
                                  "Are you sure you want to delete this post",
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
                                      _deleteEvent(keyList[index].toString());
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
                        }
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1.0,
                      color: ktextColorA,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
