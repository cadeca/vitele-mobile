import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weasylearn/utils/sidedrawer.dart';

class SettingsWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(
            'Setari',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
        ),
        drawer: SideDrawer(),
      ),
    );
  }
}
