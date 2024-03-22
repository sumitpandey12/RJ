import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rotijugaad/APIs/employer.dart';
import 'package:rotijugaad/models/EmployeeModel.dart';
import 'package:rotijugaad/models/EmployerModel.dart';
import 'package:rotijugaad/models/contactModel.dart';
import 'package:rotijugaad/models/employeeToEmployerModel.dart';
import 'package:rotijugaad/models/jobModel.dart';
import 'package:rotijugaad/models/qualificationModel.dart';
import 'package:rotijugaad/screens/Home/user_home_page.dart';
import 'package:rotijugaad/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/JobCategoryModel.dart';
import '../models/employeeSubscriptionModel.dart';
import 'endpoints.dart';

class EmployeeService {
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

  static Future<void> createProfile({
    required BuildContext context,
    required bool isPartial,
    required String? Age,
    required String? Gender,
    required String? City,
    required String? State_Ut,
    required String? Referred_By,
    required String? Qualification,
    required String? Expected_Salary,
    required String? Salary_Frequency,
    required String? Preferred_Shift,
    required String? Preferred_State_Ut,
    required String? Preferred_City,
    required String? email,
    required String? ID,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? phone = pref.getString("Phone_No");
    String? name = pref.getString("Name");

    var formData = FormData.fromMap({
      "Age": Age,
      "Gender": Gender,
      "City": City,
      "State_Ut": State_Ut,
      "Referred_By": Referred_By,
      "Qualification": Qualification,
      "Expected_Salary": Expected_Salary,
      "Salary_Frequency": Salary_Frequency,
      "Preferred_Shift": Preferred_Shift,
      "Preferred_State_Ut": Preferred_State_Ut,
      "Preferred_City": Preferred_City,
      "Email_ID": email,
      "User_ID": phone,
      "Contact_No": phone,
      "Name": name
    });

    final dio = Dio();

    if (isPartial) {
      log("${APIEndPoint.createProfile}$ID/");
      final response =
          await dio.put("${APIEndPoint.createProfile}$ID/", data: formData);
      log(response.toString());
    } else {
      final response =
          await dio.post(APIEndPoint.createProfile, data: formData);
      log(response.data.toString());
      log(response.data['EmployeeID'].toString());
      pref.setString("EmployeeId", response.data['EmployeeID'].toString());
      log(pref.getString("EmployeeId").toString());
    }
  }

  static Future<void> updateExperience({
    required BuildContext context,
    required QualificationModel experience,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? phone = pref.getString("EmployeeId");
      log("${APIEndPoint.employeeQualification}");
      log(experience.toJson().toString());

      final dio = Dio();

      final response = await dio.post(APIEndPoint.employeeQualification,
          data: experience.toJson());

      log("status code: ${response.statusCode} ,body: ${response.toString()}");
    } catch (e) {
      log("Error while update :=" + e.toString());
    }
  }

  static Future<List<QualificationModel>?> getQualification() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? phone = pref.getString("Phone_No");
      log("${APIEndPoint.employeeQualification}");

      final dio = Dio();

      final response =
          await dio.get("${APIEndPoint.employeeQualification}$phone");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((e) => QualificationModel.fromJson(e)).toList();
      }

      log("status code: ${response.statusCode} ,body: ${response.toString()}");
    } catch (e) {
      log("Error while update :=" + e.toString());
    }
  }

  static Future<bool?> updateJobPreference(
      {required BuildContext context, required List<int> jobPreference}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? employeeID = pref.getInt("EmployeeID");
      String? phone = pref.getString("Phone_No");
      log("$employeeID, $phone");

      List<Map<String, dynamic>> data = [];

      for (int i = 0; i < jobPreference.length; i++) {
        Map<String, dynamic> temp = {
          "User_ID": phone,
          "Employee_ID": employeeID,
          "Category": jobPreference[i],
        };
        data.add(temp);
      }
      log(data.toString());

      final response =
          await http.post(Uri.parse("${APIEndPoint.jobPreference}$employeeID/"),
              headers: {
                'Content-Type': 'application/json', // Set content type to JSON
              },
              body: json.encode(data));
      log(response.body.toString());
      if (response.statusCode == 201) {
        log(response.toString());
        return true;
      } else {
        log(response.toString());
        return false;
      }
    } catch (e) {
      log("Error while update :=" + e.toString());
      return false;
    }
  }

  static Future<List<JobCategoryModel>> getAllJobCategories() async {
    try {
      final response = await http.get(Uri.parse(APIEndPoint.categories));
      if (response.statusCode == 200) {
        final List<JobCategoryModel> jobPreferences =
            (json.decode(response.body) as List)
                .map((data) => JobCategoryModel.fromJson(data))
                .toList();

        return jobPreferences;
      } else {
        throw Exception('Failed to fetch job preferences');
      }
    } catch (e) {
      return [];
    }
  }

  static Future<List<JobCategoryModel>?> getJobPreference(
      int employeeID) async {
    final response =
        await http.get(Uri.parse("${APIEndPoint.jobPreference}$employeeID"));
    if (response.statusCode == 200) {
      log("Get jobPreference is found!");
      List<dynamic> data = json.decode(response.body);
      if (data.length == 0) return null; //return Null
      List<JobCategoryModel> allJobCategoris =
          await EmployeeService.getAllJobCategories();

      List<JobCategoryModel> result = [];
      // Map data to JobCategoryModel
      data.forEach((e) {
        int categoryID = e['Category'];
        JobCategoryModel? category =
            allJobCategoris.firstWhere((cat) => cat.categoryID == categoryID);
        if (category != null) {
          result.add(category);
        } else {
          log("Job category with ID $categoryID not found.");
        }
      });
      log(result.length.toString());
      return result;
    } else {
      log("Get Qualification is not found!");
      return null;
    }
  }

  static Future<bool> uploadAadhar(File adharFront, File aadharBack,
      File? profile, String adhar_number) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? phone = pref.getInt("EmployeeID");
      log("${APIEndPoint.createProfile}$phone");
      String frontName = adharFront.path.split('/').last;
      String backName = aadharBack.path.split('/').last;
      String? profileName; // Changed to nullable

      FormData data = FormData.fromMap({
        "Aadhar_Front": await MultipartFile.fromFile(
          adharFront.path,
          filename: frontName,
          contentType: MediaType("image", 'jpg'),
        ),
        "Aadhar_Back": await MultipartFile.fromFile(
          aadharBack.path,
          filename: backName,
          contentType: MediaType("image", 'jpg'),
        ),
        if (profile != null) // Added conditional check for profile
          "Profile_Picture": await MultipartFile.fromFile(
            profile.path,
            filename: profileName =
                profile.path.split('/').last, // Assigning value to profileName
            contentType: MediaType("image", 'jpg'),
          ),
        "Aadhar_Number": adhar_number,
        "Profile_Completed": true
      });

      Dio dio = new Dio();

      final response = await dio.put("${APIEndPoint.createProfile}$phone/",
          data: data,
          options: Options(headers: {
            "Accept": "*/*",
            "Content-Type": "multipart/form-data"
          }));
      log(response.toString());
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Error: " + e.toString());
      return false;
    }
  }

  static Future<EmployeeModel?> getProfile({String? empId = null}) async {
    try {
      SharedPreferences? pref;
      String? employeeId;
      if (empId == null) {
        pref = await SharedPreferences.getInstance();
        employeeId = pref.getString("EmployeeId");
      } else {
        employeeId = empId;
      }
      log("${APIEndPoint.createProfile}$employeeId/");

      if (employeeId != null) {
        final response = await http
            .get(Uri.parse("${APIEndPoint.createProfile}$employeeId"));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          log(data.toString());
          return EmployeeModel.fromJson(data);
        } else {
          log(response.body.toString());
          return null;
        }
      } else {
        String? phone = pref!.getString("Phone_No");
        final response = await http
            .get(Uri.parse("${APIEndPoint.registeredUsers}$phone/employee"));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          log(data.toString());
          return EmployeeModel.fromJson(data);
        } else {
          log(response.body.toString());
          return null;
        }
      }
    } catch (e) {
      log("Error with getProfile" + e.toString());
      return null;
    }
  }

  // static Future<void> registerUser(
  //     BuildContext context, String name, String phoneNo, String type) async {
  //   final registeredUserUrl = Uri.parse(APIEndPoint.registeredUsers);
  //   final token = await FirebaseMessaging.instance.getToken();
  //   log(token.toString());
  //   final registeredUserResponse = await http.post(
  //     registeredUserUrl,
  //     body: {
  //       'Name': name,
  //       'Phone_No': phoneNo,
  //       'Device_ID': token,
  //       'Account_Type': type,
  //     },
  //   );
  //   if (registeredUserResponse.statusCode == 201) {
  //     // Successful registration for registered users
  //     final registeredUserResponseBody = registeredUserResponse.body;
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('Name', name);
  //     prefs.setString('Phone_No', phoneNo);
  //     prefs.setString('Device_ID', token.toString());
  //     prefs.setString('Account_Type', type);
  //     log("User Registered");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) =>
  //             type == "Employer" ? EmployerHomePage() : UserHomePage(),
  //       ),
  //     );
  //   } else {
  //     // Handle registered user registration error
  //     Utils.showSnackBar(context, registeredUserResponse.body);
  //     log('Registered User Registration failed with status: ${registeredUserResponse.body}');
  //   }
  // }

  static Future<List<QualificationModel>?> getEmployeeQualification({
    String? phone,
  }) async {
    if (phone == null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      phone = pref.getString("Phone_No");
      if (phone == null) {
        log("Phone number is not found in SharedPreferences");
        return null;
      }
    }

    final response =
        await http.get(Uri.parse("${APIEndPoint.employeeQualification}$phone"));

    if (response.statusCode == 200) {
      log("Get Qualification is found!");
      List<dynamic> data = json.decode(response.body);
      List<QualificationModel> listOfQualifications =
          data.map((e) => QualificationModel.fromJson(e)).toList();
      return listOfQualifications;
    } else {
      log("Get Qualification is not found!");
      return null;
    }
  }

  static Future<bool?> postEmployeeToEmployerJobIntrest({
    required BuildContext context,
    required JobModel jobModel,
    required int Employer_ID,
  }) async {
    try {
      log("postEmployeeToEmployerJob...");
      EmployeeModel? employeeModel = await EmployeeService.getProfile();
      log("${Employer_ID}");
      EmployerModel? employerModel =
          await EmployerService.getCurrentEmployer(context, Employer_ID);

      if (employeeModel == null) {
        log("Get Profile is not found!");
        return false;
      }

      if (employerModel == null) {
        log("Get Qualification is not found!");
        return false;
      }
      final data = {
        "Job_ID": jobModel.jobID,
        "Employer_ID": Employer_ID,
        "Employee_ID": employeeModel.employeeID,
        "Organization_Name": employerModel.organization ?? "-",
        "Organization_Category": employerModel.organizationType ?? "-",
        "Photo_Url": employeeModel.profilePicture,
        "City": employerModel.city,
        "State_Ut": employerModel.stateUt,
        "Salary": jobModel.salaryOffered,
        "Salary_Frequency": jobModel.frequency,
        "Name": jobModel.jobProfile,
        "First_Pref": "test"
      };

      final response = await http.post(
        Uri.parse(APIEndPoint.postEmployeeToEmployerJob),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      log(response.body);

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

  static Future<bool?> getEmployeeToEmployerJobIntresetByJobId(
      {required String employeeId, required String jobId}) async {
    try {
      log(("${APIEndPoint.postEmployeeToEmployerJob}?employee_id=$employeeId&job_id=$jobId"));
      final response = await http.get(Uri.parse(
          "${APIEndPoint.postEmployeeToEmployerJob}?employee_id=$employeeId&job_id=$jobId"));

      if (response.statusCode == 200) {
        log(response.body.toString());
        List<dynamic> data = json.decode(response.body);
        if (data.isEmpty) {
          return false;
        } else {
          return true;
        }
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<String?> postEmployeeToEmployerCall({
    required BuildContext context,
    required JobModel jobModel,
  }) async {
    try {
      log("postEmployeeToEmployerJob...");
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? employeeID = pref.getInt("EmployeeID");
      if (employeeID == null) return null;

      EmployerModel? employerModel = await EmployerService.getCurrentEmployer(
          context, jobModel.employerID);

      if (employerModel == null) return null;

      final data = {
        "Employee_ID": employeeID,
        "Employer_ID": jobModel.employerID,
        "Job_ID": jobModel.jobID,
        "Photo_Url": jobModel.jobProfile,
        "City": jobModel.city,
        "State_Ut": jobModel.state,
        "Organization_Name": employerModel.organization,
        "Organization_Category": employerModel.organizationType,
        "Contact_No": employerModel.userID
      };

      final response = await http.post(
        Uri.parse(APIEndPoint.employeeToEmployerCall),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      log("body: ${response.body}, Status ${response.statusCode}");

      if (response.statusCode == 201) {
        log(response.body);
        ContactModel contactModel =
            ContactModel.fromJson(json.decode(response.body));
        return contactModel.contactNo;
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

  static Future<String?> getEmployeeToEmployerCall(
      {required String jobId}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? employeeId = pref.getInt("EmployeeID");
      if (employeeId == null) return null;
      log(("${APIEndPoint.employeeToEmployerCall}?employee_id=$employeeId"));
      final response = await http.get(Uri.parse(
          "${APIEndPoint.employeeToEmployerCall}?employee_id=$employeeId"));

      if (response.statusCode == 200) {
        log(response.body.toString());
        List<dynamic> data = json.decode(response.body);
        List<ContactModel> listOfContacts =
            data.map((e) => ContactModel.fromJson(e)).toList();
        String? contact;
        listOfContacts.forEach((element) {
          if (element.jobID == int.parse(jobId)) {
            contact = element.contactNo!;
          }
        });
        return contact;
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<List<EmployeeToEmployerModel>?> getAllApplications() async {
    try {
      EmployeeModel? employeeModel = await EmployeeService.getProfile();
      if (employeeModel == null) {
        log("Employee Profile Null");
        return null;
      }

      final dio = Dio();

      final response = await dio.get(
          "${APIEndPoint.getEmployeeToEmployerJob}?employee_id=${employeeModel.employeeID}");
      if (response.statusCode == 200) {
        log(response.data.toString());
        final List<dynamic> data = response.data;
        return data.map((e) => EmployeeToEmployerModel.fromJson(e)).toList();
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<List<EmployeeSubscriptionModel>> employeeSubscription() async {
    try {
      final response =
          await http.get(Uri.parse(APIEndPoint.employeeSubscription));
      log(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<EmployeeSubscriptionModel> listOfSubscription = responseData
            .map((e) => EmployeeSubscriptionModel.fromJson(e))
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

  static Future<String?> postGenerateOTP({
    required BuildContext context,
    required int jobID,
  }) async {
    try {
      log("postJobOTP...");
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? employeeID = pref.getInt("EmployeeID");
      if (employeeID == null) return null;

      final data = {"Employee_ID": employeeID, "Job_ID": jobID};

      final response = await http.post(
        Uri.parse(APIEndPoint.JobOTP),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      log("body: ${response.body}, Status ${response.statusCode}");

      if (response.statusCode == 201) {
        dynamic data = json.decode(response.body);
        return data['Otp'];
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

  static Future<String?> getGenerateOTP({
    required BuildContext context,
    required int jobID,
  }) async {
    try {
      log("postJobOTP...");
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? employeeID = pref.getInt("EmployeeID");
      if (employeeID == null) return null;

      final data = {"Employee_ID": employeeID, "Job_ID": jobID};

      final response =
          await http.get(Uri.parse("${APIEndPoint.JobOTP}$employeeID/$jobID"));

      log("body: ${response.body}, Status ${response.statusCode}");

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        return data['Otp'];
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
