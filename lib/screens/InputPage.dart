import 'package:flutter/material.dart';
import 'package:stopwatch/components/textbox.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/screens/StopWatch.dart';
import 'package:stopwatch/components/watchbuttons.dart';
import 'dart:async';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final textController_1 = TextEditingController();
  final textController_2 = TextEditingController();
  final textController_3 = TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2021),
    );
    final TimeOfDay picked2 = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        _time = picked2;
        textController_2.text = _date.year.toString() +
            '-' +
            _date.month.toString() +
            '-' +
            _date.day.toString() +
            ' ' +
            _time.hour.toString() +
            ':' +
            _time.minute.toString();
      });
    }
  }

  checkTextFieldEmptyOrNot() {
    String text1, text2, text3;

    text1 = textController_1.text;
    text2 = textController_2.text;
    text3 = textController_3.text;

    if (text1 == '' || text2 == '' || text3 == '') {
      return false;
    } else {
      return true;
    }
  }

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            EventTextBox(
              hint: 'Event Name',
              keybrd: TextInputType.text,
              lines: 1,
              myController: textController_1,
            ),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: IgnorePointer(
                child: EventTextBox(
                  hint: 'Event Date',
                  keybrd: TextInputType.datetime,
                  lines: 1,
                  myController: textController_2,
                ),
              ),
            ),
            EventTextBox(
              hint: 'Event Description',
              keybrd: TextInputType.text,
              lines: 6,
              myController: textController_3,
            ),
            Builder(
              builder: (context) => WatchButton(
                buttontitle: 'START EVENT',
                onTap: () {
                  if (checkTextFieldEmptyOrNot() == true) {
                    Navigator.pushNamed(context, 'stopwatch_screen');
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        backgroundColor: kbuttonColor,
                        content: Text(
                          'Please fill in all the text fields',
                          style: TextStyle(
                            color: ktextColorA,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
                textcolor: ktextColorA,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
