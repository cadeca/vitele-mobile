import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
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
  Dio dio = Dio();

  final ImagePicker imagePicker = ImagePicker();

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
                    _showPicker(context);
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

  void _uploadImg(ImageSource source) async {
    final authResponse = await authService.authenticate();
    final requestURL = 'http://10.0.2.2:2020/api/user/profile/image';
    PickedFile image = await imagePicker.getImage(
      source: source,
      imageQuality: 50,
    );
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(image.path,
          filename: basename(image.path))
    });
    final response = await dio.post(
      requestURL,
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer ' + authResponse.accessToken},
      ),
    );
    setState(() {});
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Galerie'),
                    onTap: () {
                      _uploadImg(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _uploadImg(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
