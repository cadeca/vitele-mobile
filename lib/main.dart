import 'package:flutter/material.dart';
import 'package:weasylearn/login/login.dart';
import 'package:weasylearn/subjects/subjects.dart';

void main() {
  runApp(WeasyApp());
}

class WeasyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeasyLearn',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: LoginApp(),
    );
  }

}


