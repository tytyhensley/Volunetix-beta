import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stopwatch/screens/volunteer/addEvent/addEvent1.dart';

class VolunteerEventList extends StatefulWidget {
  @override
  _VolunteerEventListState createState() => _VolunteerEventListState();
}

class _VolunteerEventListState extends State<VolunteerEventList> {
  final DatabaseReference _checkEvent =
      FirebaseDatabase.instance.reference().child('Events');
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  bool showSpinner = false;

  var keyList = List();
  var nameList = List();
  var data;
  var holder = 'No events';
  int index;
  bool show = true;

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
        _checkEvent.once().then((value) {
          data = value.value;
          if (data != null) {
            data.keys.forEach((k) => {
                  keyList.add(k),
                  _checkEvent.child(k.toString()).once().then((value) {
                    var eventdata = value.value;
                    nameList.add(eventdata['organization']);
                  }).then((value) {
                    setState(() {
                      showSpinner = false;
                    });
                  }),
                });
          } else {
            keyList.add(holder);
            nameList.add(' ');
            setState(() {
              showSpinner = false;
            });
          }
        });
      });
    } catch (e) {}
  }

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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          height: double.maxFinite,
          color: Colors.white,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: keyList.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              keyList[index].toString(),
                              style: kTitleTextStyle.copyWith(
                                color: ktextColorD,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Host: ' + nameList[index].toString(),
                              style: kTitleTextStyle.copyWith(
                                color: ktextColorD,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            show = true;
                          });
                          if (keyList[index].toString() != holder) {
                            _checkEvent
                                .child(keyList[index].toString())
                                .child('volunteers')
                                .once()
                                .then((value) {
                              var voldata = value.value;
                              if (voldata != null && voldata != '') {
                                voldata.keys.forEach((k) => {
                                      if (k.toString() == loggedInUser.uid)
                                        {
                                          show = false,
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddEvent1(
                                                name: keyList[index].toString(),
                                              ),
                                            ),
                                          ),
                                        }
                                    });
                              }
                              if (show == true) {
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
                                        "You have not been added to this event, try contacting " +
                                            nameList[index].toString() +
                                            " so that you can be added ",
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            "Okay",
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
                            });
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
                  ),
                );
              }),
        ),
      ),
    );
  }
}
