import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:weasylearn/representation/Subject.dart';
import 'package:weasylearn/subjects/subjectnotification.dart';
import 'package:weasylearn/subjects/teacherRadio.dart';
import 'package:weasylearn/utils/fancyappbar.dart';
import 'package:http/http.dart' as http;

class CreateSubjectWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateSubjectState();
}

class CreateSubjectState extends State<CreateSubjectWidget> {
  Subject _subject = Subject();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            FancyAppBar(
              title: 'Adauga Materie',
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black87,
                child: _createFormForSubjects(),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            if (_formKey.currentState.validate() && _subject.teacher != null) {
              final response = _createSubject(_subject);
              response.whenComplete(
                () => showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text('Materie salvata!'),
                    actions: [
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              showDialog(
                context: context,
                child: AlertDialog(
                  title: Text('Trebuie sa completati toate informatiile!'),
                  actions: [
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Form _createFormForSubjects() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _createTextFormField(
            labelText: 'Numele materiei',
            validateText: 'Numele nu poate fi gol!',
            icon: Icon(Icons.subject),
            onChange: (String value) {
              setState(() {
                _subject.name = value;
              });
            },
          ),
          _createTextFormField(
            labelText: 'Codul materiei',
            validateText: 'Codul nu poate fi gol!',
            icon: Icon(Icons.code),
            onChange: (String value) {
              setState(() {
                _subject.code = value;
              });
            },
          ),
          _createTextFormField(
            labelText: 'Descrierea materiei',
            validateText: 'Descrierea nu poate fi goala!',
            icon: Icon(Icons.description),
            onChange: (String value) {
              setState(() {
                _subject.description = value;
              });
            },
          ),
          Row(
            children: [
              Container(
                color: Colors.grey,
                padding:
                    EdgeInsets.only(top: 12, bottom: 12, left: 5, right: 5),
                child: Icon(Icons.account_box),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey,
                  padding:
                      EdgeInsets.only(top: 20, bottom: 12, right: 10, left: 20),
                  child: _subject.teacher != null
                      ? Text(_subject.teacher.UIvalue)
                      : Text('Niciun profesor selectat'),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    color: Colors.blueGrey,
                    padding: EdgeInsets.only(
                        top: 20, bottom: 12, left: 22, right: 20),
                    child: Text('Selecteaza profesorul'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          content: TeacherRadio(
                            subject: _subject,
                            parent: this,
                          ),
                          actions: [
                            FlatButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          _createTextFormField(
            labelText: 'Semestrul',
            validateText: 'Semestrul nu poate fi gol!',
            icon: Icon(Icons.access_time),
            onChange: (String value) {
              setState(() {
                _subject.semester = int.parse(value);
              });
            },
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Container _createTextFormField(
      {String labelText,
      String validateText,
      Icon icon,
      bool readOnly = false,
      ValueChanged<String> onChange,
      TextInputType keyboardType = TextInputType.text}) {
    return Container(
      color: Colors.grey,
      child: TextFormField(
        readOnly: readOnly,
        keyboardType: keyboardType,
        onChanged: onChange,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10, bottom: 10),
          isDense: true,
          labelText: labelText,
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 15),
            child: icon,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return validateText;
          }
          return null;
        },
        inputFormatters: [
          keyboardType == TextInputType.number
              ? FilteringTextInputFormatter.allow(RegExp('[12345678]'))
              : FilteringTextInputFormatter.singleLineFormatter,
        ],
      ),
    );
  }

  Future<Response> _createSubject(Subject subject) async {
    final response = await http.post(
      'http://10.0.2.2:2020/api/subject',
      body: jsonEncode(subject.toJson()),
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
        HttpHeaders.authorizationHeader: base64Encode(
          utf8.encode('admin:admin'),
        ),
      },
    );
    return response;
  }
}
