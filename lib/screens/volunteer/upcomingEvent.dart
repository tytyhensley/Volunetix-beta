import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:firebase_database/firebase_database.dart';

class VolunteerUpcomingEvent extends StatefulWidget {
  @override
  _VolunteerUpcomingEventState createState() => _VolunteerUpcomingEventState();
}

class _VolunteerUpcomingEventState extends State<VolunteerUpcomingEvent> {
  final DatabaseReference _getEvent =
      FirebaseDatabase.instance.reference().child('UpcomingEvents');
  var nameList = List();
  var data;
  bool showSpinner = false;
  var holder = 'No upcoming events';

  void _eventInfo(context, index) {
    _getEvent.child(nameList[index]).once().then((value) {
      var voldata = value.value;
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Container(
              color: Colors.black,
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: ktextColorD,
                      size: 14.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "When",
                    style: kAppTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    voldata['dateOfFutureEvent'],
                    style: kAppTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Name",
                    style: kAppTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    voldata['event'],
                    style: kAppTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Host",
                    style: kAppTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    voldata['organization'],
                    style: kAppTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Description",
                    style: kAppTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    voldata['description'],
                    style: kAppTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }

  @override
  void initState() {
    super.initState();
    checkEvent();
  }

  void checkEvent() {
    showSpinner = true;
    _getEvent.once().then((value) {
      data = value.value;
      if (data != null) {
        data.keys.forEach((k) => {
              nameList.add(k),
            });
      } else {
        nameList.add(holder);
      }
      setState(() {
        showSpinner = false;
      });
    });
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
              itemCount: nameList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        child: Text(
                          nameList[index].toString(),
                          style: kTitleTextStyle.copyWith(
                            color: ktextColorD,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          if (nameList[index].toString() != holder) {
                            _eventInfo(context, index);
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
                    ]);
              }),
        ),
      ),
    );
  }
}
