class QualificationModel {
  int? qualificationID;
  String? organization;
  String? role;
  int? duration;
  String? durationType;
  String? userID;
  int? employeeID;

  QualificationModel(
      {this.qualificationID,
      this.organization,
      this.role,
      this.duration,
      this.durationType,
      this.userID,
      this.employeeID});

  QualificationModel.fromJson(Map<String, dynamic> json) {
    qualificationID = json['QualificationID'];
    organization = json['Organization'];
    role = json['Role'];
    duration = json['Duration'];
    durationType = json['DurationType'];
    userID = json['User_ID'].toString();
    employeeID = json['Employee_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['QualificationID'] = this.qualificationID;
    data['Organization'] = this.organization;
    data['Role'] = this.role;
    data['Duration'] = this.duration;
    data['DurationType'] = this.durationType;
    data['User_ID'] = this.userID;
    data['Employee_ID'] = this.employeeID;
    return data;
  }
}
