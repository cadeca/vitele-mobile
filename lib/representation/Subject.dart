import 'package:weasylearn/representation/Teacher.dart';

class Subject {

  String name;
  String code;
  String description;
  Teacher teacher;
  int semester;
  int id;

  Subject({this.name, this.code, this.description, this.semester, this.id, this.teacher});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
        name: json['name'],
        code: json['code'],
        description: json['description'],
        semester: json['semester'],
        id: json['id'],
        teacher: Teacher(
          username: json['teacher']['username'],
          firstName: json['teacher']['firstName'],
          lastName: json['teacher']['lastName'],
        ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'description': description,
      'semester': semester,
      'teacher': teacher.username,
      'id': id
    };
  }
}
