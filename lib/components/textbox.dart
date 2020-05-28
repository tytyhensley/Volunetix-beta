import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  final String label;
  final TextInputType keybrd;
  final int lines;
  final TextEditingController myController;

  TextBox({
    this.label,
    @required this.keybrd,
    @required this.lines,
    this.myController,
  });
  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
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
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          //  when the TextFormField in unfocused
        ),
      ),
    );
  }
}
