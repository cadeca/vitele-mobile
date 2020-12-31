import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:weasylearn/utils/service/auth_service.dart';
import 'package:weasylearn/utils/service/custom_form_field.dart';
import 'package:weasylearn/utils/side_drawer.dart';
import 'package:http/http.dart' as http;

class SettingsWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<SettingsWidget> {
  final AuthService authService = AuthService.getInstance();

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
        body: getSettingsBody(),
      ),
    );
  }

  FutureBuilder getSettingsBody() {
    return FutureBuilder<Image>(
      future: fetchProfilePicture(),
      builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black87,
            child: Column(
              children: [
                SizedBox(height: 100.0),
                GestureDetector(
                  onTap: () {
                    uploadPicture();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: snapshot.data,
                  ),
                ),
                SizedBox(height: 45.0),
                CustomTextFormField(
                  labelText: 'Numele de utilizator',
                  icon: Icon(Icons.account_box),
                  initialValue: authService.getUsername(),
                  readOnly: true,
                ),
                CustomTextFormField(
                  labelText: 'Nume',
                  icon: Icon(Icons.assignment),
                  initialValue: authService.getName(),
                  readOnly: true,
                ),
                CustomTextFormField(
                  labelText: 'Prenume',
                  icon: Icon(Icons.assignment),
                  initialValue: authService.getSurname(),
                  readOnly: true,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<Image> fetchProfilePicture() async {
    final authResponse = await authService.authenticate();
    final response = await http.get(
      'http://10.0.2.2:2020/api/user/profile/image',
      headers: {'Authorization': 'Bearer ' + authResponse.accessToken},
    );
    final bodyBytes = response.bodyBytes;
    return bodyBytes != null && bodyBytes.isNotEmpty
        ? Image.memory(
            bodyBytes,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          )
        : Image.asset(
            'assets/default_profile_picture.png',
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          );
  }

  void uploadPicture() async{
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
  }

}
