class Teacher {

  final String firstName;
  final String lastName;
  final String username;

  Teacher({this.firstName, this.lastName, this.username});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
        firstName: json['firstName'],
        lastName: json['lastName'],
        username: json['username'],
    );
  }

}
