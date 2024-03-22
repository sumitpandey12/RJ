String BASEURL = "https://rajaryan9358.pythonanywhere.com/";

class APIEndPoint {
  static String registeredUsers = "$BASEURL/api/registered-users/";
  static String checkLogin = "$BASEURL/api/registered-users/";
  //Employee

  static String jobPreference = "${BASEURL}api/employee-jobpreference/";
  static String employeeToEmployerCall =
      "${BASEURL}api/employee-to-employer-call/";
  static String employeeSubscription = "${BASEURL}api/employee-subscriptions/";

  //Employer

  static String availableCandidate = "${BASEURL}api/available-candidates";
  static String employerToEmployeeIntrest =
      "${BASEURL}api/employer-to-employee-job/";
  static String employerToEmployeeCall =
      "${BASEURL}api/employer-to-employee-call/";
  static String employerSubscription = "${BASEURL}api/employer-subscriptions/";

  //Data

  static String employers = "$BASEURL/api/employers/";
  static String getJobs = "$BASEURL/api/jobs/";
  static String categories = "${BASEURL}api/job-categories/";
  static String createProfile = "${BASEURL}api/employees/";
  static String referedBy = "${BASEURL}api/referred-by/";
  static String employeeQualification = "${BASEURL}api/employee-qualification/";
  static String postEmployeeToEmployerJob =
      "${BASEURL}api/employee-to-employer-job/";
  static String getEmployeeToEmployerJob =
      "${BASEURL}api/employee-to-employer-job/";
  static String postEmployerToEmployeeJob =
      "${BASEURL}api/employer-to-employee-job/";

  //OTP
  static String JobOTP = "${BASEURL}api/job-otp/";
  static String hiringTable = "${BASEURL}api/hiring-table/";
}
