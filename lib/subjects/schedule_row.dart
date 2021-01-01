import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduleRow extends StatelessWidget {
  final Widget child;

  ScheduleRow({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 14.0,
      ),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: child,
    );
  }
}
