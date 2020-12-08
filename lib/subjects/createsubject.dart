import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weasylearn/subjects/teacherRadio.dart';
import 'package:weasylearn/utils/fancyappbar.dart';

class CreateSubjectWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateSubjectState();
}

class _CreateSubjectState extends State<CreateSubjectWidget> {

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
            if (_formKey.currentState.validate()) {
              showDialog(
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
          ),
          _createTextFormField(
            labelText: 'Codul materiei',
            validateText: 'Codul nu poate fi gol!',
            icon: Icon(Icons.code),
          ),
          _createTextFormField(
            labelText: 'Descrierea materiei',
            validateText: 'Descrierea nu poate fi goala!',
            icon: Icon(Icons.description),
          ),
          FlatButton(
            child: Text('Selecteaza profesorul'),
            onPressed: () {
              showDialog(
                context: context,
                child: AlertDialog(
                  content: TeacherRadio(),
                  actions: [
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              );
            },
          ),
        ],
      ),
    );
  }

  Container _createTextFormField(
      {String labelText, String validateText, Icon icon}) {
    return Container(
      color: Colors.grey,
      child: TextFormField(
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
      ),
    );
  }
}
