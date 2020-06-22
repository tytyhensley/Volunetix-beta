import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';

class EventBox extends StatefulWidget {
  final String label;
  final String hint;
  final TextInputType keybrd;
  final int lines;
  final TextEditingController myController;

  EventBox({
    this.label,
    this.hint,
    @required this.keybrd,
    @required this.lines,
    this.myController,
  });
  @override
  _EventBoxState createState() => _EventBoxState();
}

class _EventBoxState extends State<EventBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.myController,
      maxLines: widget.lines,
      style: TextStyle(
        color: Colors.yellow[300],
        fontSize: 18.0,
      ),
      keyboardType: widget.keybrd,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          filled: true,
          fillColor: ktextColorD,
          hintText: widget.hint,
          hintStyle: kAppTextStyle.copyWith(
            color: Colors.yellow[300],
          )),
    );
  }
}
