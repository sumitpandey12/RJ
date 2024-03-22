class EmployerModel {
  int? employerID;
  bool? active;
  bool? approved;
  bool? profileCompleted;
  String? name;
  String? organization;
  String? city;
  String? stateUt;
  String? emailID;
  String? organizationType;
  String? address;
  int? totalJobPostCredits;
  int? totalContactCredits;
  int? totalInterestCredits;
  int? jobPostCredits;
  int? contactCredits;
  int? interestCredits;
  String? validity;
  String? deviceID;
  String? referredBy;
  int? userID;
  int? activePack;

  EmployerModel(
      {this.employerID,
      this.active,
      this.approved,
      this.profileCompleted,
      this.name,
      this.organization,
      this.city,
      this.stateUt,
      this.emailID,
      this.organizationType,
      this.address,
      this.totalJobPostCredits,
      this.totalContactCredits,
      this.totalInterestCredits,
      this.jobPostCredits,
      this.contactCredits,
      this.interestCredits,
      this.validity,
      this.deviceID,
      this.referredBy,
      this.userID,
      this.activePack});

  EmployerModel.fromJson(Map<String, dynamic> json) {
    employerID = json['EmployerID'];
    active = json['Active'];
    approved = json['Approved'];
    profileCompleted = json['Profile_Completed'];
    name = json['Name'];
    organization = json['Organization'];
    city = json['City'];
    stateUt = json['State_Ut'];
    emailID = json['Email_ID'];
    organizationType = json['Organization_Type'];
    address = json['Address'];
    totalJobPostCredits = json['Total_Job_Post_Credits'];
    totalContactCredits = json['Total_Contact_Credits'];
    totalInterestCredits = json['Total_Interest_Credits'];
    jobPostCredits = json['Job_Post_Credits'];
    contactCredits = json['Contact_Credits'];
    interestCredits = json['Interest_Credits'];
    validity = json['Validity'];
    deviceID = json['Device_ID'];
    referredBy = json['Referred_By'];
    userID = json['User_ID'];
    activePack = json['Active_Pack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployerID'] = this.employerID;
    data['Active'] = this.active;
    data['Approved'] = this.approved;
    data['Profile_Completed'] = this.profileCompleted;
    data['Name'] = this.name;
    data['Organization'] = this.organization;
    data['City'] = this.city;
    data['State_Ut'] = this.stateUt;
    data['Email_ID'] = this.emailID;
    data['Organization_Type'] = this.organizationType;
    data['Address'] = this.address;
    data['Total_Job_Post_Credits'] = this.totalJobPostCredits;
    data['Total_Contact_Credits'] = this.totalContactCredits;
    data['Total_Interest_Credits'] = this.totalInterestCredits;
    data['Job_Post_Credits'] = this.jobPostCredits;
    data['Contact_Credits'] = this.contactCredits;
    data['Interest_Credits'] = this.interestCredits;
    data['Validity'] = this.validity;
    data['Device_ID'] = this.deviceID;
    data['Referred_By'] = this.referredBy;
    data['User_ID'] = this.userID;
    data['Active_Pack'] = this.activePack;
    return data;
  }
}
