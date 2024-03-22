class ContactModel {
  int? id;
  String? date;
  String? organizationName;
  String? organizationCategory;
  String? photoUrl;
  String? city;
  String? stateUt;
  String? contactNo;
  int? employeeID;
  int? employerID;
  int? jobID;

  ContactModel(
      {this.id,
      this.date,
      this.organizationName,
      this.organizationCategory,
      this.photoUrl,
      this.city,
      this.stateUt,
      this.contactNo,
      this.employeeID,
      this.employerID,
      this.jobID});

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['Date'];
    organizationName = json['Organization_Name'];
    organizationCategory = json['Organization_Category'];
    photoUrl = json['Photo_Url'];
    city = json['City'];
    stateUt = json['State_Ut'];
    contactNo = json['Contact_No'];
    employeeID = json['Employee_ID'];
    employerID = json['Employer_ID'];
    jobID = json['Job_ID'];
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
    data['Contact_No'] = this.contactNo;
    data['Employee_ID'] = this.employeeID;
    data['Employer_ID'] = this.employerID;
    data['Job_ID'] = this.jobID;
    return data;
  }
}
