import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/screens/charity/createEvent/createEvent3.dart';

class CreateEvent2 extends StatefulWidget {
  final String name;
  final String des;

  CreateEvent2({this.des, this.name});

  @override
  _CreateEvent2State createState() => _CreateEvent2State();
}

class _CreateEvent2State extends State<CreateEvent2> {
  List<String> _tasklist = ['Insert Tasks'];

  Future<String> createTaskDialog(BuildContext context) {
    TextEditingController textController_1 = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Task Name',
              textAlign: TextAlign.center,
              style: kAppTextStyle.copyWith(
                color: ktextColorD,
                fontSize: 14,
              ),
            ),
            content: TextField(
              controller: textController_1,
            ),
            actions: <Widget>[
              Center(
                child: MaterialButton(
                  elevation: 5.0,
                  child: Text('CREATE'),
                  onPressed: () {
                    Navigator.of(context).pop(textController_1.text.toString());
                  },
                ),
              )
            ],
          );
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
            Image.asset(
              'assets/images/volunetixLogoSmall.png',
              color: Colors.white,
              fit: BoxFit.contain,
              height: 32,
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Think about the metrics you want to track and report from this event',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 15,
                ),
              ),
              Text(
                'This is critical to get the best reports!',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _tasklist.length,
                  itemBuilder: (context, position) {
                    return Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 12.0, 12.0, 6.0),
                              child: Text(
                                _tasklist[position],
                                style: kAppTextStyle.copyWith(
                                  color: ktextColorD,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(Icons.close),
                                color: Colors.red,
                                iconSize: 14,
                                onPressed: () {
                                  setState(() {
                                    if (_tasklist[position].toString() !=
                                        'Insert Tasks') {
                                      if (_tasklist.length == 1) {
                                        _tasklist.removeAt(0);
                                        _tasklist.add('Insert Tasks');
                                      } else {
                                        _tasklist.remove(_tasklist[position]);
                                      }
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                child: Container(
                  color: ktextColorD,
                  width: double.infinity,
                  child: Text(
                    'Add Tasks',
                    textAlign: TextAlign.center,
                    style: kAppTextStyle.copyWith(
                      fontSize: 20.0,
                      color: ktextColorA,
                    ),
                  ),
                ),
                onTap: () {
                  createTaskDialog(context).then((task) {
                    setState(() {
                      if (_tasklist[0].toString() == 'Insert Tasks') {
                        _tasklist.removeAt(0);
                        _tasklist.add(task);
                      } else {
                        _tasklist.add(task);
                      }
                    });
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                child: Text(
                  'Next',
                  style: kAppTextStyle.copyWith(
                    fontSize: 20.0,
                    color: ktextColorD,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () async {
                  if (_tasklist[0].toString() != 'Insert Tasks') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: Text(
                            "Ready To Create Event",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          content: Text(
                            "This will begin your event",
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateEvent3(
                                      name: widget.name,
                                      des: widget.des,
                                      tasks: _tasklist,
                                    ),
                                  ),
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
                            "Please enter at least one task",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
