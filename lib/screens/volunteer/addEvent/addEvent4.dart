import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/screens/volunteer/addEvent/addEvent3.dart';

class AddEvent4 extends StatefulWidget {
  final String name;
  final List<String> taskslist;

  AddEvent4({this.name, this.taskslist});
  @override
  _AddEvent4State createState() => _AddEvent4State();
}

class _AddEvent4State extends State<AddEvent4> {
  final DatabaseReference _updateEvent =
      FirebaseDatabase.instance.reference().child('Events');
  var data;
  List<String> taskList = List();
  bool showSpinner = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      _updateEvent.child(widget.name).child('tasks').once().then((value) {
        data = value.value;
      }).then((value) {
        setState(() {
          showSpinner = false;
        });
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  if (taskList.isNotEmpty == true) {
                    print(taskList);
                    widget.taskslist.clear();
                    widget.taskslist.addAll(taskList);
                  } else {
                    widget.taskslist.clear();
                    widget.taskslist.add('No tasks');
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEvent3(
                        name: widget.name,
                        taskslist: widget.taskslist,
                      ),
                    ),
                  );
                },
                child: Icon(
                  Icons.close,
                  color: ktextColorD,
                  size: 20.0,
                ),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      value: taskList.contains(data[index].toString()),
                      onChanged: (bool selected) {
                        if (selected == true) {
                          setState(() {
                            taskList.add(data[index].toString());
                          });
                          print(taskList);
                        } else {
                          setState(() {
                            taskList.remove(data[index].toString());
                          });
                        }
                      },
                      title: Text(
                        data[index].toString(),
                        style: kAppTextStyle.copyWith(
                          color: ktextColorD,
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
