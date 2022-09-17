class UserModel {
  String? userId;
  String? password;
  String? userName;
  String? department;
  String? email;
  String? section;
  String? uId;

  UserModel(
      {this.userId,
      this.password,
      this.userName,
      this.department,
      this.email,
      this.section,
      this.uId});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uId: map['uId'],
        userId: map['userID'],
        password: map['password'],
        userName: map['userName'],
        department: map['department'],
        email: map['email'],
        section: map['section']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'userID': userId,
      'password': password,
      'userName': userName,
      'department': department,
      'email': email,
      'section': section
    };
  }
}
