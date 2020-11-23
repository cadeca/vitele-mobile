import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<List<Subject>> fetchSubjects() async {
  final response = await http.get(
    'localhost:8080/api/subject',
    headers: {HttpHeaders.authorizationHeader: base64Encode(utf8.encode("student:student"))},
  );
  final Iterable responseJson = jsonDecode(response.body);
  List<Subject> subjects = List.from(responseJson).map((model) => Subject.fromJson(model)).toList();
  return subjects;
}

class Subject {

  final String name;
  final String code;
  final String description;
  final int semester;
  final int id;

  Subject({this.name, this.code, this.description, this.semester, this.id});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json['name'],
      code: json['code'],
      description: json['description'],
      semester: json['semester'],
      id: json['id']
    );
  }

}

class Subjects extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  }

}