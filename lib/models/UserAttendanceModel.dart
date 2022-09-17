class UserAttendanceModel {
  String? date;
  String? department;
  String? Period;
  String? Section;
  String? Subject;
  String? UserId;
  String? UserName;
  String? AId;
  UserAttendanceModel({
    this.date,
    this.department,
    this.Period,
    this.Section,
    this.Subject,
    this.UserId,
    this.UserName,
    this.AId,
  });

  factory UserAttendanceModel.fromMap(
      map, String? _date, String? _UserId, String? _UserName) {
    return UserAttendanceModel(
        date: map['date'],
        department: map['department'],
        Period: map['Period'],
        Section: map['Section'],
        Subject: map['Subject'],
        UserId: map['UserId'],
        UserName: map['UserName'],
        AId: map['AId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'department': department,
      'Period': Period,
      'Section': Section,
      'Subject': Subject,
      'UserId': UserId,
      'AId': AId
    };
  }
}
