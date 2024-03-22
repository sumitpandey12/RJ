import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rotijugaad/models/EmployerModel.dart';
import 'package:rotijugaad/models/hiringModel.dart';
import 'package:rotijugaad/screens/Home/user_home_page.dart';
import 'package:rotijugaad/screens/Login/login_screen.dart';
import 'package:rotijugaad/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/EmployeeModel.dart';
import '../models/contactModel.dart';
import '../models/employeeSubscriptionModel.dart';
import '../models/employerSubscriptionModel.dart';
import '../models/jobModel.dart';
import '../screens/Home/emp_home_page.dart';
import '../screens/SignUp/choice_page.dart';
import 'endpoints.dart';

class EmployerService {
  static Future<EmployerModel?> getCurrentEmployer(
      BuildContext context, int? employerID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? storedEmployerID = pref.getInt("EmployerID");
    log(storedEmployerID.toString());

    int? targetEmployerID = employerID ?? storedEmployerID;

    if (targetEmployerID == null) {
      String? phone = pref.getString("Phone_No");
      final response = await http
          .get(Uri.parse("${APIEndPoint.registeredUsers}$phone/employer"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        log(data.toString());

        if (data['detail'] == "Not found.") {
          return null;
        }

        return EmployerModel.fromJson(data);
      }
    } else {
      try {
        final response = await http
            .get(Uri.parse("${APIEndPoint.employers}$targetEmployerID"));
        final data = json.decode(response.body);
        log(data.toString());
        if (data['detail'] == "Not found.") {
          return null;
        }
        return EmployerModel.fromJson(data);
      } catch (e) {
        log("Error while fromJson" + e.toString());
      }
    }
  }

  static Future<void> registerUser(
      BuildContext context, String name, String phoneNo, String type) async {
    final registeredUserUrl = Uri.parse(APIEndPoint.registeredUsers);
    final token = await FirebaseMessaging.instance.getToken();
    log(token.toString());
    final registeredUserResponse = await http.post(
      registeredUserUrl,
      body: {
        'Name': name,
        'Phone_No': phoneNo,
        'Device_ID': token,
        'Account_Type': type,
      },
    );
    log(registeredUserResponse.body);
    if (registeredUserResponse.statusCode == 201) {
      // Successful registration for registered users
      final registeredUserResponseBody = registeredUserResponse.body;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Name', name);
      prefs.setString('Phone_No', phoneNo);
      prefs.setString('Device_ID', token.toString());
      prefs.setString('Account_Type', type);
      log("User Registered");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => type == "Employer"
                ? const EmployerHomePage()
                : const UserHomePage(),
          ),
          (route) => false);
    } else {
      // Handle registered user registration error
      Utils.showSnackBar(context, registeredUserResponse.body);
      // EmployerService().dialog_for_login(context);
      log('Registered User Registration failed with status: ${registeredUserResponse.body}');
    }
  }

  static Future<void> postPersonalDetails(
      BuildContext context,
      String organization,
      String city,
      String state,
      String email,
      String organizationType,
      String address,
      String referred_by) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final employerUrl = Uri.parse(APIEndPoint.employers);
    final Map<String, dynamic> employerRequestBody = {
      'User_ID': prefs.getString("Phone_No"),
      'Name': prefs.getString("Name"),
      'Organization': organization,
      'City': city,
      'State_Ut': state,
      'Email_ID': email,
      'Organization_Type': organizationType,
      'Address': address,
      "Profile_Completed": true
    };

    final employerResponse = await http.post(
      employerUrl,
      body: json.encode(employerRequestBody),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (employerResponse.statusCode == 201) {
      // Successful registration for employers
      final employerResponseBody = json.decode(employerResponse.body);
      // Process the response data as needed
      log('Employer Registration successful: $employerResponseBody');
      prefs.setInt("EmployerID", employerResponseBody['EmployerID']);
      log(prefs.getInt("EmployerID").toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployerHomePage(),
        ),
      );
    } else {
      // Handle employer registration error
      log('Employer Registration failed with status: ${employerResponse.body}');
    }
  }

  static Future<bool?> updateEmail(String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? employerID = pref.getInt("EmployerID");
    if (employerID != null) {
      final response = await http
          .put(Uri.parse("${APIEndPoint.employers}$employerID/"), body: {
        "Email_ID": email,
      });
      if (response.statusCode == 200) {
        log("Email Update : $email");
        return true;
      } else {
        log(response.statusCode.toString());
        return false;
      }
    } else {
      log("EmployerID not found");
    }

    return false;
  }

  static Future<String?> checkLogin(
      BuildContext context, String phoneNo) async {
    final checklogin = Uri.parse("${APIEndPoint.checkLogin}$phoneNo");
    final loginResponse = await http.get(checklogin);
    if (loginResponse.statusCode != 200) {
      Utils.showSnackBar(context, "You are not registered yet!");
      log("Not Registered Yet");
      EmployerService().dialog_for_signup(context);
      return null;
    }
    log("Registered");
    // Successful registration for registered users
    final loginResponseBody = json.decode(loginResponse.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Name', loginResponseBody['Name']);
    prefs.setString('Phone_No', loginResponseBody['Phone_No'].toString());
    prefs.setString('Device_ID', loginResponseBody['Device_ID']);
    prefs.setString('Account_Type', loginResponseBody['Account_Type']);
    log("${prefs.getString("Account_Type")}");
    return loginResponseBody['Account_Type'];
  }

  Future<dynamic> dialog_for_login(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.15,
            height: MediaQuery.of(context).size.width / 1.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Already Registered",
                      style: const TextStyle(
                        color: Color(0xFFFF0000),
                        decorationThickness: 0,
                        //decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "You phone are already registered!. click to login",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        decorationThickness: 0,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => login_page(),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color(0xFF0098DA),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            decorationThickness: 0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> dialog_for_signup(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.15,
            height: MediaQuery.of(context).size.width / 1.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Not Registered!",
                      style: const TextStyle(
                        color: Color(0xFFFF0000),
                        decorationThickness: 0,
                        //decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Your number is not registered. Click here for SignUp",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        decorationThickness: 0,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => choice_page(),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color(0xFF0098DA),
                      ),
                      child: Center(
                        child: Text(
                          "SignUp",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            decorationThickness: 0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<List<JobModel>?> getJobs() async {
    try {
      final response = await http.get(Uri.parse(APIEndPoint.getJobs));

      if (response.statusCode == 200) {
        final List<JobModel> listOfJobModel =
            (json.decode(response.body) as List)
                .map((data) => JobModel.fromJson(data))
                .toList();

        return listOfJobModel;
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      log("Error: $e");
    }
    return null;
  }

  static Future<List<JobModel>?> getJobsByID({int? empId}) async {
    int? employerID;
    if (empId == null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      employerID = pref.getInt("EmployerID");
    } else {
      employerID = empId;
    }

    log(employerID.toString());
    try {
      if (employerID != null) {
        final response =
            await http.get(Uri.parse("${APIEndPoint.getJobs}$employerID/"));

        if (response.statusCode == 200) {
          final List<JobModel> listOfJobModel =
              (json.decode(response.body) as List)
                  .map((data) => JobModel.fromJson(data))
                  .toList();

          return listOfJobModel;
        } else {
          throw Exception('Failed to load jobs');
        }
      } else {
        return [];
      }
    } catch (e) {
      log("Error: $e");
    }
    return [];
  }

  static Future<JobModel?> postJobs(
      String jobTitle,
      String vacancy,
      String salary,
      String frequency,
      String EmployerID,
      String contactNo,
      String city,
      String state) async {
    try {
      final response = await http.post(Uri.parse(APIEndPoint.getJobs), body: {
        "Job_Profile": jobTitle,
        "Vacancy": vacancy,
        "Salary_Offered": salary,
        "Frequency": frequency,
        "Employer_ID": EmployerID,
        "Contact_No": contactNo,
        "City": city,
        "State": state
      });

      if (response.statusCode == 201) {
        final JobModel listOfJobModel =
            JobModel.fromJson(json.decode(response.body));
        log(response.body);
        return listOfJobModel;
      } else {
        log(response.body);
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      log("Error: $e");
    }
    return null;
  }

  static Future<String?> updateJobs(
    JobModel jobmodel,
    String salary,
    String frequency,
  ) async {
    try {
      final response = await http
          .put(Uri.parse("${APIEndPoint.getJobs}${jobmodel.jobID}/"), body: {
        "Job_Profile": jobmodel.jobProfile,
        "Vacancy": "${jobmodel.vacancy}",
        "Salary_Offered": salary,
        "Frequency": frequency,
        "Employer_ID": "${jobmodel.employerID}",
        "Contact_No": jobmodel.contactNo,
        "City": jobmodel.city,
        "State": jobmodel.state
      });

      if (response.statusCode == 201) {
        log(response.body);
        return response.body;
      } else {
        log(response.body);
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      log("Error: $e");
    }
    return null;
  }

  static Future<List<EmployeeModel>?> getAvailableCandidates(
      {required String frequency}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? employerId = pref.getInt("EmployerID");
      if (employerId == null) return [];
      log("${APIEndPoint.availableCandidate}?employer_id=$employerId&frequency=$frequency");

      final response = await http.get(Uri.parse(
          "${APIEndPoint.availableCandidate}?employer_id=$employerId&frequency=$frequency"));
      log(response.body.toString());
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => EmployeeModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log("Error: " + e.toString());
      return [];
    }
  }

  static Future<bool?> postEmployerToEmployeeJobIntrest({
    required BuildContext context,
    required JobModel jobModel,
    required int Employee_ID,
  }) async {
    try {
      final data = {
        "Job_ID": jobModel.jobID,
        "Employer_ID": jobModel.employerID,
        "Employee_ID": Employee_ID,
        "Photo_Url": (jobModel.jobImage == null || jobModel.jobImage!.isEmpty)
            ? "-"
            : jobModel.jobImage,
        "City": jobModel.city,
        "State_Ut": jobModel.state,
        "Salary": jobModel.salaryOffered,
        "Salary_Frequency": jobModel.frequency,
        "Name": jobModel.jobProfile,
        "First_Pref": "test"
      };
      log(data.toString());

      final response = await http.post(
        Uri.parse(APIEndPoint.employerToEmployeeIntrest),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      log("body:${response.body}, status: ${response.statusCode}");

      if (response.statusCode == 201) {
        log(response.body);
        log("SUCCESS ---------------------");
        return true;
      } else {
        log(response.body);
        log("FAILED ---------------------");
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool?> getEmployerToEmployerJobIntresetByJobId({
    required int Employee_ID,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? employerId = pref.getInt("EmployerID");

      log(("${APIEndPoint.employerToEmployeeIntrest}?employer_id=$employerId"));
      final response = await http.get(Uri.parse(
          "${APIEndPoint.employerToEmployeeIntrest}?employer_id=$employerId"));

      if (response.statusCode == 200) {
        log(response.body.toString());
        List<dynamic> data = json.decode(response.body);
        bool result = false;
        if (data.isEmpty) return false;

        data.forEach((element) {
          if (element['Employee_ID'] == Employee_ID) {
            result = true;
          }
        });
        return result;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<String?> postEmployerToEmployeeCall(
      {required BuildContext context,
      required JobModel jobModel,
      required int employeeId}) async {
    try {
      log("postEmployerToEmployeeCalling...");
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? employerID = pref.getInt("EmployerID");
      if (employerID == null) return null;

      EmployerModel? employerModel = await EmployerService.getCurrentEmployer(
          context, jobModel.employerID);

      if (employerModel == null) return null;

      final data = {
        "Job_ID": jobModel.jobID,
        "Employee_ID": employeeId,
        "Employer_ID": employerID,
        "Photo_Url": (jobModel.jobImage == null || jobModel.jobImage!.isEmpty)
            ? "-"
            : jobModel.jobImage,
        "City": jobModel.city,
        "State_Ut": jobModel.state,
        "Salary": jobModel.salaryOffered,
        "Salary_Frequency": jobModel.frequency,
        "Name": employerModel.organization,
        "First_Pref": "test",
        "Contact_No": employerModel.userID
      };

      final response = await http.post(
        Uri.parse(BASEURL + "api/employer-to-employee-call/"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      log(response.statusCode.toString());

      if (response.statusCode == 201) {
        log(response.body);
        dynamic data = json.decode(response.body);
        return data['Contact_No'];
      } else {
        log(response.body);
        log("FAILED ---------------------");
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<String?> getEmployerToEmployeeCall(
      {required int employeeId}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? employerId = pref.getInt("EmployerID");
      if (employerId == null) return null;
      log(("${APIEndPoint.employeeToEmployerCall}?employer_id=$employerId&employee_id=$employeeId"));
      final response = await http.get(Uri.parse(
          "${APIEndPoint.employerToEmployeeCall}?employer_id=$employerId&employee_id=$employeeId"));

      if (response.statusCode == 200) {
        log(response.body.toString());
        List<dynamic> data = json.decode(response.body);
        return data[0]['Contact_No'];
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<List<EmployerSubscriptionModel>> employerSubscription() async {
    try {
      final response =
          await http.get(Uri.parse(APIEndPoint.employerSubscription));
      log(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<EmployerSubscriptionModel> listOfSubscription = responseData
            .map((e) => EmployerSubscriptionModel.fromJson(e))
            .toList();
        return listOfSubscription;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<bool> postHiringTable({
    required BuildContext context,
    required int jobID,
    required int employeeID,
    required String otp,
  }) async {
    try {
      log("postJobOTP...");
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? employerID = pref.getInt("EmployerID");
      if (employerID == null) return false;

      final data = {
        "Employee_ID": employeeID,
        "Employer_ID": employerID,
        "Job_ID": jobID,
        "Otp": otp
      };
      log("Data: $data");

      final response = await http.post(
        Uri.parse(APIEndPoint.hiringTable),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      log("body: ${response.body}, Status ${response.statusCode}");

      if (response.statusCode == 201) {
        return true;
      } else {
        log(response.body);
        log("FAILED ---------------------");
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<List<HiringModel>?> getHiringTable({
    required BuildContext context,
  }) async {
    try {
      log("getHiringTable...");
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? employerID = pref.getInt("EmployerID");
      if (employerID == null) return null;

      final response =
          await http.get(Uri.parse("${APIEndPoint.hiringTable}$employerID/"));

      log("body: ${response.body}, Status ${response.statusCode}");

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => HiringModel.fromJson(e)).toList();
      } else {
        log(response.body);
        log("FAILED ---------------------");
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
