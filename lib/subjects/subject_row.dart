import 'package:flutter/material.dart';
import 'package:weasylearn/representation/Subject.dart';
import 'package:weasylearn/subjects/subject_widget.dart';
import 'package:weasylearn/utils/service/auth_service.dart';

class SubjectRow extends StatelessWidget {
  final AuthService authService = AuthService.getInstance();

  final Subject subject;

  SubjectRow({this.subject});

  final headerTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
  );

  final subHeaderTextStyle = TextStyle(
    fontFamily: 'Poppins',
    color: Colors.indigo,
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (authService.isAdmin) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SubjectWidget(subject)),
          );
        }
      },
      child: Container(
        height: 90.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 14.0,
        ),
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              constraints: BoxConstraints.expand(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 4.0),
                  Text(
                    subject.code,
                    style: headerTextStyle,
                  ),
                  Container(height: 10.0),
                  Text(
                    '${subject.teacher.firstName} ${subject.teacher.lastName}',
                    style: subHeaderTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
