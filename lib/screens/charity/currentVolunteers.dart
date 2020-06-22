import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:firebase_database/firebase_database.dart';

class CurrentVolunteer extends StatefulWidget {
  final String name;
  final int vol;

  CurrentVolunteer({this.name, this.vol});
  @override
  _CurrentVolunteerState createState() => _CurrentVolunteerState();
}

class _CurrentVolunteerState extends State<CurrentVolunteer> {
  final DatabaseReference _checkEvent =
      FirebaseDatabase.instance.reference().child('Events');
  var nameList = List();
  var keyList = List();
  var data;
  bool showSpinner = false;

  void _volunteerInfo(context, index) {
    _checkEvent
        .child(widget.name)
        .child('volunteers')
        .child(keyList[index])
        .once()
        .then((value) {
      var voldata = value.value;
      var lists = List();
      voldata.forEach((k, v) => {lists.add('$k: $v')});
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
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lists.length,
                      itemBuilder: (context, position) {
                        return Container(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                lists[position].toString(),
                                style: kAppTextStyle.copyWith(
                                  color: ktextColorD,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
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
    _checkEvent.child(widget.name).child('volunteers').once().then((value) {
      data = value.value;
      data.keys.forEach((k) => {
            keyList.add(k),
            _checkEvent
                .child(widget.name)
                .child('volunteers')
                .child(k.toString())
                .once()
                .then((value) {
              var voldata = value.value;
              nameList.add(voldata['name']);
            }).then((value) {
              setState(() {
                showSpinner = false;
              });
            })
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ktextColorD,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Volunteers: ${widget.vol}',
              style: kAppTextStyle.copyWith(
                color: Colors.white,
              ),
            )
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
                        _volunteerInfo(context, index);
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
