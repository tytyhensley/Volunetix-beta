import 'package:flutter/material.dart';

class PasswordTextBox extends StatefulWidget {
  final String label;
  final TextInputType keybrd;
  final int lines;
  final TextEditingController myController;

  PasswordTextBox({
    @required this.label,
    @required this.keybrd,
    @required this.lines,
    this.myController,
  });
  @override
  _PasswordTextBoxState createState() => _PasswordTextBoxState();
}

class _PasswordTextBoxState extends State<PasswordTextBox> {
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
