import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:weasylearn/representation/Subject.dart';
import 'package:weasylearn/subjects/subject_widget.dart';
import 'package:weasylearn/subjects/subject_row.dart';
import 'package:weasylearn/utils/service/auth_service.dart';
import 'package:weasylearn/utils/side_drawer.dart';

class SubjectsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubjectsWidgetState();
  }
}

class _SubjectsWidgetState extends State<SubjectsWidget> {
  final AuthService authService = AuthService.getInstance();

  List<Subject> subjects;

  _SubjectsWidgetState({this.subjects});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Materii",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(
            'Materii',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
        ),
        drawer: SideDrawer(),
        body: Column(
          children: [
            _subjectsData(),
          ],
        ),
        floatingActionButton: getAddButton(),
      ),
    );
  }

  Widget getAddButton() {
    return Visibility(
      visible: authService.isAdmin,
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SubjectWidget(null)),
          );
        },
      ),
    );
  }

  FutureBuilder _subjectsData() {
    return FutureBuilder<List<Subject>>(
      future: fetchSubjects(),
      builder: (BuildContext context, AsyncSnapshot<List<Subject>> snapshot) {
        if (snapshot.hasData) {
          List<Subject> data = snapshot.data;
          return _subjects(data);
        } else if (snapshot.hasError) {
          return Text(
            snapshot.error.toString(),
          );
        }
        return Column(
          children: [
            SizedBox(height: 250.0),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      },
    );
  }

  Expanded _subjects(data) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black87,
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              sliver: SliverFixedExtentList(
                itemExtent: 120.0,
                delegate: SliverChildBuilderDelegate(
                  (context, index) => SubjectRow(
                    subject: data[index],
                  ),
                  childCount: data != null ? data.length : 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Subject>> fetchSubjects() async {
    final authResponse = await authService.authenticate();
    final response = await http.get(
      'http://10.0.2.2:2020/api/subject',
      headers: {'Authorization': 'Bearer ' + authResponse.accessToken},
    );
    final Iterable responseJson = jsonDecode(response.body);
    List<Subject> subjects = List.from(responseJson)
        .map((model) => Subject.fromJson(model))
        .toList();
    return subjects;
  }

}
