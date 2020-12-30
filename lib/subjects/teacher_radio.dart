import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weasylearn/representation/Subject.dart';
import 'package:weasylearn/representation/Teacher.dart';
import 'package:http/http.dart' as http;
import 'package:weasylearn/utils/service/auth_service.dart';

Future<List<Teacher>> fetchTeachers() async {
  final authResponse = await AuthService.getInstance().authenticate();
  final response = await http.get(
    'http://10.0.2.2:2020/api/user/teachers',
    headers: {
      'Authorization': 'Bearer ' + authResponse.accessToken
    },
  );
  final Iterable responseJson = jsonDecode(response.body);
  List<Teacher> teachers =
      List.from(responseJson).map((model) => Teacher.fromJson(model)).toList();
  return teachers;
}

class TeacherRadio extends StatefulWidget {

  final Subject subject;

  final State parent;

  TeacherRadio ({this.subject, this.parent});

  @override
  State<StatefulWidget> createState() => _TeacherRadioState(subject, parent);

}

class _TeacherRadioState extends State<TeacherRadio> {

  Subject _subject;

  String _teacherName;

  final State parent;

  _TeacherRadioState(Subject subject, this.parent) {
    this._subject = subject;
    if (_subject.teacher != null) {
      _teacherName = _subject.teacher.UIvalue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _teachersData();
  }

  FutureBuilder _teachersData() {
    return FutureBuilder<List<Teacher>>(
      future: fetchTeachers(),
      builder: (BuildContext context, AsyncSnapshot<List<Teacher>> snapshot) {
        if (snapshot.hasData) {
          List<Teacher> data = snapshot.data;
          return _teachers(data);
        } else if (snapshot.hasError) {
          return Text(
            snapshot.error.toString(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Container _teachers(List<Teacher> data) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 1.0),
              sliver: SliverFixedExtentList(
                itemExtent: 60.0,
                delegate: SliverChildBuilderDelegate(
                  (context, index) => RadioListTile(
                    title: Text('${data[index].firstName} ${data[index].lastName}'),
                    value: '${data[index].firstName} ${data[index].lastName}',
                    groupValue: _teacherName,
                    onChanged: (String value) {
                      setState(() {
                        _teacherName = value;
                        _subject.teacher = data.where((element) => element.UIvalue == value).first;
                        parent.setState(() {

                        });
                      });
                    },
                  ),
                  childCount: data != null ? data.length : 0,
                ),
              ),
            ),
          ],
        ),
      );
  }
}
