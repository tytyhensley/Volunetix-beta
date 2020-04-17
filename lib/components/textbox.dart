import 'package:stopwatch/components/constants.dart';
import 'package:flutter/material.dart';

class EventTextBox extends StatefulWidget {
  final String hint;
  final TextInputType keybrd;
  final int lines;
  final TextEditingController myController;

  EventTextBox(
      {@required this.hint,
      @required this.keybrd,
      @required this.lines,
      this.myController});
  @override
  _EventTextBoxState createState() => _EventTextBoxState();
}

class _EventTextBoxState extends State<EventTextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: TextField(
        controller: widget.myController,
        cursorColor: ktextColorA,
        maxLines: widget.lines,
        style: TextStyle(
          color: ktextColorA,
          fontSize: 22.0,
        ),
        keyboardType: widget.keybrd,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Color(0xA09C9C9C),
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: Color(0xFF151515),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
