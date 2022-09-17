class FacultyModel {
  String? fId;
  String? password;
  String? name;
  String? department;
  String? email;

  FacultyModel({
    this.fId,
    this.password,
    this.name,
    this.department,
    this.email,
  });

  // receiving data from server
  factory FacultyModel.fromMap(map) {
    return FacultyModel(
      fId: map['fId'],
      password: map['password'],
      name: map['name'],
      department: map['department'],
      email: map['email'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'fId': fId,
      'password': password,
      'name': name,
      'department': department,
      'email': email,
    };
  }
}
