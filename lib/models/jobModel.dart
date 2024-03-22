class JobModel {
  int? jobID;
  String? jobProfile;
  int? vacancy;
  String? contactNo;
  String? city;
  String? state;
  int? salaryOffered;
  String? frequency;
  int? sentInterests;
  int? receivedInterests;
  String? jobImage;
  int? employerID;

  JobModel(
      {this.jobID,
      this.jobProfile,
      this.vacancy,
      this.contactNo,
      this.city,
      this.state,
      this.salaryOffered,
      this.frequency,
      this.sentInterests,
      this.receivedInterests,
      this.jobImage,
      this.employerID});

  JobModel.fromJson(Map<String, dynamic> json) {
    jobID = json['Job_ID'];
    jobProfile = json['Job_Profile'];
    vacancy = json['Vacancy'];
    contactNo = json['Contact_No'];
    city = json['City'];
    state = json['State'];
    salaryOffered = json['Salary_Offered'];
    frequency = json['Frequency'];
    sentInterests = json['Sent_Interests'];
    receivedInterests = json['Received_Interests'];
    jobImage = json['Job_Image'];
    employerID = json['Employer_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Job_ID'] = this.jobID;
    data['Job_Profile'] = this.jobProfile;
    data['Vacancy'] = this.vacancy;
    data['Contact_No'] = this.contactNo;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Salary_Offered'] = this.salaryOffered;
    data['Frequency'] = this.frequency;
    data['Sent_Interests'] = this.sentInterests;
    data['Received_Interests'] = this.receivedInterests;
    data['Job_Image'] = this.jobImage;
    data['Employer_ID'] = this.employerID;
    return data;
  }
}
