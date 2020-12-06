import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:weasylearn/data/Subject.dart';
import 'package:weasylearn/subjects/subjectrow.dart';
import 'package:weasylearn/utils/fancyappbar.dart';

Future<List<Subject>> fetchSubjects() async {
  final response = await http.get(
    'http://10.0.2.2:2020/api/subject',
    headers: {
      HttpHeaders.authorizationHeader:
          base64Encode(utf8.encode("student:student"))
    },
  );
  final Iterable responseJson = jsonDecode(response.body);
  List<Subject> subjects =
      List.from(responseJson).map((model) => Subject.fromJson(model)).toList();
  return subjects;
}

class SubjectsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubjectsWidgetState();
  }
}

class _SubjectsWidgetState extends State<SubjectsWidget> {
  List<Subject> subjects;

  _SubjectsWidgetState({this.subjects});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Materii",
      home: Scaffold(
        body: Column(
          children: [
            FancyAppBar(
              title: "Materii",
            ),
            _subjectsData(),
          ],
        ),
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
        return CircularProgressIndicator();
      },
    );
  }

  Expanded _subjects(data) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black87,
        child: new CustomScrollView(
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
}
