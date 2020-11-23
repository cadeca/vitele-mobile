import 'package:flutter/material.dart';
import 'file:///C:/Users/Dragos/Desktop/weasyapp/weasylearn/lib/login/login.dart';

void main() => runApp(WeasyApp());

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


