class EmployeeModel {
  int? employeeID;
  bool? active;
  bool? approved;
  bool? profileCompleted;
  String? name;
  String? contactNo;
  int? age;
  String? gender;
  String? stateUt;
  String? city;
  String? referredBy;
  String? qualification;
  int? expectedSalary;
  String? salaryFrequency;
  String? preferredShift;
  String? preferredStateUt;
  String? preferredCity;
  String? emailID;
  String? experience;
  String? jobPreference;
  String? profilePicture;
  String? aadharNumber;
  String? aadharFront;
  String? aadharBack;
  int? contactCredits;
  int? interestCredits;
  int? totalContactCredits;
  int? totalInterestCredits;
  String? validity;
  int? profileOTP;
  String? deviceID;
  int? userID;
  int? activePack;

  EmployeeModel(
      {this.employeeID,
      this.active,
      this.approved,
      this.profileCompleted,
      this.name,
      this.contactNo,
      this.age,
      this.gender,
      this.stateUt,
      this.city,
      this.referredBy,
      this.qualification,
      this.expectedSalary,
      this.salaryFrequency,
      this.preferredShift,
      this.preferredStateUt,
      this.preferredCity,
      this.emailID,
      this.experience,
      this.jobPreference,
      this.profilePicture,
      this.aadharNumber,
      this.aadharFront,
      this.aadharBack,
      this.contactCredits,
      this.interestCredits,
      this.totalContactCredits,
      this.totalInterestCredits,
      this.validity,
      this.profileOTP,
      this.deviceID,
      this.userID,
      this.activePack});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    employeeID = json['EmployeeID'];
    active = json['Active'];
    approved = json['Approved'];
    profileCompleted = json['Profile_Completed'];
    name = json['Name'];
    contactNo = json['Contact_No'];
    age = json['Age'];
    gender = json['Gender'];
    stateUt = json['State_Ut'];
    city = json['City'];
    referredBy = json['Referred_By'];
    qualification = json['Qualification'];
    expectedSalary = json['Expected_Salary'];
    salaryFrequency = json['Salary_Frequency'];
    preferredShift = json['Preferred_Shift'];
    preferredStateUt = json['Preferred_State_Ut'];
    preferredCity = json['Preferred_City'];
    emailID = json['Email_ID'];
    experience = json['Experience'];
    jobPreference = json['Job_Preference'];
    profilePicture = json['Profile_Picture'];
    aadharNumber = json['Aadhar_Number'];
    aadharFront = json['Aadhar_Front'];
    aadharBack = json['Aadhar_Back'];
    contactCredits = json['Contact_Credits'];
    interestCredits = json['Interest_Credits'];
    totalContactCredits = json['Total_Contact_Credits'];
    totalInterestCredits = json['Total_Interest_Credits'];
    validity = json['Validity'];
    profileOTP = json['Profile_OTP'];
    deviceID = json['Device_ID'];
    userID = json['User_ID'];
    activePack = json['Active_Pack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeID'] = this.employeeID;
    data['Active'] = this.active;
    data['Approved'] = this.approved;
    data['Profile_Completed'] = this.profileCompleted;
    data['Name'] = this.name;
    data['Contact_No'] = this.contactNo;
    data['Age'] = this.age;
    data['Gender'] = this.gender;
    data['State_Ut'] = this.stateUt;
    data['City'] = this.city;
    data['Referred_By'] = this.referredBy;
    data['Qualification'] = this.qualification;
    data['Expected_Salary'] = this.expectedSalary;
    data['Salary_Frequency'] = this.salaryFrequency;
    data['Preferred_Shift'] = this.preferredShift;
    data['Preferred_State_Ut'] = this.preferredStateUt;
    data['Preferred_City'] = this.preferredCity;
    data['Email_ID'] = this.emailID;
    data['Experience'] = this.experience;
    data['Job_Preference'] = this.jobPreference;
    data['Profile_Picture'] = this.profilePicture;
    data['Aadhar_Number'] = this.aadharNumber;
    data['Aadhar_Front'] = this.aadharFront;
    data['Aadhar_Back'] = this.aadharBack;
    data['Contact_Credits'] = this.contactCredits;
    data['Interest_Credits'] = this.interestCredits;
    data['Total_Contact_Credits'] = this.totalContactCredits;
    data['Total_Interest_Credits'] = this.totalInterestCredits;
    data['Validity'] = this.validity;
    data['Profile_OTP'] = this.profileOTP;
    data['Device_ID'] = this.deviceID;
    data['User_ID'] = this.userID;
    data['Active_Pack'] = this.activePack;
    return data;
  }
}

class Experience {
  final String organization;
  final String role;
  final String duration;

  Experience({
    required this.organization,
    required this.role,
    required this.duration,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      organization: json['organization'] ?? '',
      role: json['role'] ?? '',
      duration: json['duration'] ?? '',
    );
  }
}
