import 'package:flutter/cupertino.dart';
import 'package:weasylearn/representation/Subject.dart';

@immutable
class SubjectNotification extends Notification{

  final Subject subject;

  const SubjectNotification(this.subject);

  String toString(){
    return subject.toString();
  }
}