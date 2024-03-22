class EmployeeToEmployerModel {
  int? id;
  String? date;
  String? organizationName;
  String? organizationCategory;
  String? photoUrl;
  String? city;
  String? stateUt;
  int? salary;
  String? salaryFrequency;
  String? name;
  String? firstPref;
  int? jobID;
  int? employeeID;
  int? employerID;

  EmployeeToEmployerModel(
      {this.id,
      this.date,
      this.organizationName,
      this.organizationCategory,
      this.photoUrl,
      this.city,
      this.stateUt,
      this.salary,
      this.salaryFrequency,
      this.name,
      this.firstPref,
      this.jobID,
      this.employeeID,
      this.employerID});

  EmployeeToEmployerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['Date'];
    organizationName = json['Organization_Name'];
    organizationCategory = json['Organization_Category'];
    photoUrl = json['Photo_Url'];
    city = json['City'];
    stateUt = json['State_Ut'];
    salary = json['Salary'];
    salaryFrequency = json['Salary_Frequency'];
    name = json['Name'];
    firstPref = json['First_Pref'];
    jobID = json['Job_ID'];
    employeeID = json['Employee_ID'];
    employerID = json['Employer_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Date'] = this.date;
    data['Organization_Name'] = this.organizationName;
    data['Organization_Category'] = this.organizationCategory;
    data['Photo_Url'] = this.photoUrl;
    data['City'] = this.city;
    data['State_Ut'] = this.stateUt;
    data['Salary'] = this.salary;
    data['Salary_Frequency'] = this.salaryFrequency;
    data['Name'] = this.name;
    data['First_Pref'] = this.firstPref;
    data['Job_ID'] = this.jobID;
    data['Employee_ID'] = this.employeeID;
    data['Employer_ID'] = this.employerID;
    return data;
  }
}
