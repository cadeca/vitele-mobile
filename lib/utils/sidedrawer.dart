import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weasylearn/settings/settings.dart';
import 'package:weasylearn/subjects/subjects.dart';
import 'package:weasylearn/users/users.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black87,
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                'WeasyLearn',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Setari',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsWidget()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Materii',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubjectsWidget()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Utilizatori',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersWidget()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
