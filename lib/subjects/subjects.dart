import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:weasylearn/data/Subject.dart';
import 'package:weasylearn/subjects/subjectrow.dart';

Future<List<Subject>> fetchSubjects() async {
  final response = await http.get(
    'localhost:8080/api/subject',
    headers: {HttpHeaders.authorizationHeader: base64Encode(utf8.encode("student:student"))},
  );
  final Iterable responseJson = jsonDecode(response.body);
  List<Subject> subjects = List.from(responseJson).map((model) => Subject.fromJson(model)).toList();
  return subjects;
}

class SubjectsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubjectsWidgetState(subjects: Subject.generateTestData());
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
        appBar: AppBar(
          title: Text("Materiile Mele"),
        ),
        body: ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final item = subjects[index];
              return SubjectRow(
                subject: item,
              );
            },
        ),
      ),
    );
  }

}