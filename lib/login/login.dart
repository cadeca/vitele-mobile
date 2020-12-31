import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:weasylearn/subjects/subjects.dart';
import 'package:weasylearn/utils/service/auth_service.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();

class LoginApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {

  final AuthService authService = AuthService.getInstance();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            final response = authService.authenticate();
            response.whenComplete(() => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubjectsWidget()),
                ));
          },
          child: Text('Login'),
        ),
      ],
    );
  }
}
