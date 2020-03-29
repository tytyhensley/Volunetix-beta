import 'package:stopwatch/components/constants.dart';
import 'package:flutter/material.dart';

class EventTextBox extends StatelessWidget {
  EventTextBox({
    @required this.hint,
    @required this.keybrd,
    @required this.lines,
  });

  final String hint;
  final TextInputType keybrd;
  final int lines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: TextField(
        cursorColor: ktextColorA,
        maxLines: lines,
        style: TextStyle(
          color: ktextColorA,
          fontSize: 22.0,
        ),
        keyboardType: keybrd,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: hint,
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
