class User {
  final String firstName;
  final String lastName;
  final String username;
  final String dateOfBirth;
  final String profilePicture;
  final String email;

  User(
      {this.firstName,
      this.lastName,
      this.username,
      this.dateOfBirth,
      this.profilePicture,
      this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      dateOfBirth: json['dateOfBirth'],
      profilePicture: json['profilePicture'],
      email: json['email'],
    );
  }
}
