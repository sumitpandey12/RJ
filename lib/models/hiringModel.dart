class HiringModel {
  int? id;
  String? date;
  String? candidateName;
  String? jobProfile;
  int? salary;
  String? salaryFrequency;
  String? aadharNo;
  String? contactNo;
  int? jobID;
  int? employeeID;
  int? employerID;

  HiringModel(
      {this.id,
      this.date,
      this.candidateName,
      this.jobProfile,
      this.salary,
      this.salaryFrequency,
      this.aadharNo,
      this.contactNo,
      this.jobID,
      this.employeeID,
      this.employerID});

  HiringModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['Date'];
    candidateName = json['Candidate_Name'];
    jobProfile = json['Job_Profile'];
    salary = json['Salary'];
    salaryFrequency = json['Salary_Frequency'];
    aadharNo = json['Aadhar_No'];
    contactNo = json['Contact_No'];
    jobID = json['Job_ID'];
    employeeID = json['Employee_ID'];
    employerID = json['Employer_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Date'] = this.date;
    data['Candidate_Name'] = this.candidateName;
    data['Job_Profile'] = this.jobProfile;
    data['Salary'] = this.salary;
    data['Salary_Frequency'] = this.salaryFrequency;
    data['Aadhar_No'] = this.aadharNo;
    data['Contact_No'] = this.contactNo;
    data['Job_ID'] = this.jobID;
    data['Employee_ID'] = this.employeeID;
    data['Employer_ID'] = this.employerID;
    return data;
  }
}
