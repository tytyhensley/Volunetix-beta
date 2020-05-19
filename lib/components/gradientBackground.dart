import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  GradientBackground({
    this.child,
    @required this.begin,
    @required this.end,
  });

  final Widget child;
  final Alignment begin;
  final Alignment end;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple[700],
            Colors.deepPurple[200],
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          tileMode: TileMode.clamp,
        ),
      ),
      child: child,
    );
  }
}
