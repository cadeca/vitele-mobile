import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weasylearn/utils/sidedrawer.dart';

class UsersWidget extends StatefulWidget {

  State<StatefulWidget> createState() {
    return UsersState();
  }

}

class UsersState extends State<UsersWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(
            'Utilizatori',
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