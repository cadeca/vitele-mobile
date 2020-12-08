import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weasylearn/representation/Teacher.dart';
import 'package:http/http.dart' as http;

Future<List<Teacher>> fetchTeachers() async {
  final response = await http.get(
    'http://10.0.2.2:2020/api/user/teachers',
    headers: {
      HttpHeaders.authorizationHeader: base64Encode(
        utf8.encode("admin:admin"),
      ),
    },
  );
  final Iterable responseJson = jsonDecode(response.body);
  List<Teacher> teachers = List.from(responseJson).map((model) => Teacher.fromJson(model)).toList();
  return teachers;
}

class TeacherRadio extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _TeacherRadioState();

}

class _TeacherRadioState extends State<TeacherRadio> {

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }

}