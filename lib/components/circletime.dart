import 'package:flutter/material.dart';

class CircleTime extends StatelessWidget {
  const CircleTime({
    @required this.timedisplay,
  });

  final String timedisplay;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 300.0,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple[700],
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        timedisplay,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
