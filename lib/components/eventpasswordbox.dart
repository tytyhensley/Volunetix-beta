import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';

class EventPasswordBox extends StatefulWidget {
  final String label;
  final String hint;
  final TextInputType keybrd;
  final int lines;
  final TextEditingController myController;

  EventPasswordBox({
    this.label,
    this.hint,
    @required this.keybrd,
    @required this.lines,
    this.myController,
  });
  @override
  _EventPasswordBoxState createState() => _EventPasswordBoxState();
}

class _EventPasswordBoxState extends State<EventPasswordBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
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
