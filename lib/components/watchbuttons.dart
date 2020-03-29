import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'constants.dart';

class WatchButton extends StatelessWidget {
  WatchButton(
      {@required this.buttontitle,
      @required this.onTap,
      @required this.textcolor});

  final Color textcolor;
  final String buttontitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: RaisedButton(
        onPressed: onTap,
        color: kbuttonColor,
        disabledColor: kbuttonColor,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: AutoSizeText(
          buttontitle,
          style: TextStyle(
            color: textcolor,
            fontSize: 23.0,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
