class Subject {

  final String name;
  final String code;
  final String description;
  final String teacher;
  final List<String> tutors;
  final int semester;
  final int id;

  Subject({this.name, this.code, this.description, this.semester, this.id, this.teacher, this.tutors});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
        name: json['name'],
        code: json['code'],
        description: json['description'],
        semester: json['semester'],
        id: json['id'],
        teacher: "${json['teacher']['firstName']} ${json['teacher']['lastName']}",
    );
  }

  static List<Subject> generateTestData() {
      return [
        Subject(name: "Fundamente de Inginerie Software",
          code: "FIS",
          description: "Test",
          semester: 2,
          teacher: "Radu Marinescu"),
        Subject(
            name: "Proiectarea si detaliarea bazelor de date",
            code: "PBD",
            description: "Test",
            semester: 1,
            teacher: "Ionel Jian"),
      ];
  }

}
