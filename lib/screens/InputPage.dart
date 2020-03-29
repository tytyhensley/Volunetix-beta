import 'package:flutter/material.dart';
import 'package:stopwatch/components/textbox.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/screens/StopWatch.dart';
import 'package:stopwatch/components/watchbuttons.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'New Event',
          style: kAppTextStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          EventTextBox(
            hint: 'Event Name',
            keybrd: TextInputType.text,
            lines: 1,
          ),
          EventTextBox(
            hint: 'Event Date',
            keybrd: TextInputType.datetime,
            lines: 1,
          ),
          EventTextBox(
            hint: 'Event Description',
            keybrd: TextInputType.text,
            lines: 6,
          ),
          WatchButton(
            buttontitle: 'START EVENT',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StopWatch(),
                ),
              );
            },
            textcolor: ktextColorA,
          ),
        ],
      ),
    );
  }
}
