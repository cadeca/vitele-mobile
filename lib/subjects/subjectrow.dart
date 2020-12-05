import 'package:flutter/material.dart';
import 'package:weasylearn/data/Subject.dart';

class SubjectRow extends StatelessWidget {

  Subject subject;

  SubjectRow({this.subject});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 80.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 14.0,
      ),
      decoration: BoxDecoration(
        color: Colors.black54,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0)
          )
        ]
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            constraints: BoxConstraints.expand(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: 4.0),
                Text(
                  subject.code,
                ),
                Container(height: 10.0),
                Text(
                  subject.teacher,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}