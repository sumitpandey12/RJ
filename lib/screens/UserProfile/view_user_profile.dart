import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rotijugaad/APIs/employer.dart';
import 'package:rotijugaad/screens/UserProfile/hire_complete.dart';
import 'package:rotijugaad/models/EmployerModel.dart';
import 'package:rotijugaad/utils/utils.dart';

import '../../APIs/employee.dart';
import '../../models/EmployeeModel.dart';
import '../../models/JobCategoryModel.dart';
import '../../models/jobModel.dart';
import '../../models/qualificationModel.dart';
import '../Subscription/emp_subscription.dart';

class ViewUserProfile extends StatefulWidget {
  final EmployeeModel userData;
  final EmployerModel employerModel;

  ViewUserProfile({required this.userData, required this.employerModel});
  @override
  _ViewUserProfileState createState() => _ViewUserProfileState();
}

class _ViewUserProfileState extends State<ViewUserProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool emp_get_contact = false;
  bool emp_send_interest = false;
  bool user_send_interest = false;
  bool isHiring = false;
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  //bool contactVisible = true;
  String userContact = "";

  EmployeeModel? employe;
  List<QualificationModel>? listOfQualifications;
  List<JobCategoryModel>? listOfJobCategory;
  List<JobModel>? listOfJobs;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getData();
  }

  getData() async {
    listOfQualifications = await EmployeeService.getEmployeeQualification(
        phone: widget.userData.userID.toString());
    listOfJobCategory =
        await EmployeeService.getJobPreference(widget.userData.employeeID!);
    listOfJobs = await EmployerService.getJobsByID(empId: 1);
    bool? response =
        await EmployerService.getEmployerToEmployerJobIntresetByJobId(
            Employee_ID: widget.userData.employeeID!);
    String? contact = await EmployerService.getEmployerToEmployeeCall(
        employeeId: widget.userData.employeeID!);
    if (contact != null) {
      userContact = contact;
      emp_get_contact = true;
    }

    if (response != null) {
      log("JOB INTREST : ${response.toString()}");
      emp_send_interest = response;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.userData.name}'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(
                      'https://randomuser.me/api/portraits/men/51.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  '${widget.userData.name}',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!emp_get_contact &&
                        !user_send_interest &&
                        !emp_send_interest)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (listOfJobs == null ||
                                  listOfJobs?.length == 0) {
                                Utils.showSnackBar(
                                    context, "No Jobs Posted Yet!");
                                return;
                              }
                              if (widget.employerModel.interestCredits! < 1) {
                                Utils.expire_dialog(
                                  context: context,
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EmpSubscription(),
                                        ))
                                  },
                                  button: "Buy Subscription",
                                  title: 'Your Subscription Has Expired!',
                                  subTitle: "Buy Subscription to send Interest",
                                );
                                return;
                              }
                              showJobSelectionDialog(
                                context,
                                listOfJobs!,
                                (result) async {
                                  bool? response = await EmployerService
                                      .postEmployerToEmployeeJobIntrest(
                                          context: context,
                                          jobModel: result!,
                                          Employee_ID: 1);
                                  if (response == true) {
                                    Utils.showSnackBar(
                                        context, "Intrest Send!");
                                  } else {
                                    Utils.showSnackBar(
                                        context, "Intrest Failed!");
                                  }
                                  if (response == null) {
                                    Utils.showSnackBar(
                                        context, "Intrest Failed!");
                                  } else {
                                    setState(() {
                                      emp_send_interest = response;
                                    });
                                  }
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                              child: const Text(
                                'Send Interest',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (widget.employerModel.contactCredits! < 1) {
                                Utils.expire_dialog(
                                  context: context,
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EmpSubscription(),
                                        ))
                                  },
                                  button: "Buy Subscription",
                                  title: 'Your Subscription Has Expired!',
                                  subTitle: "Buy Subscription to get Contact",
                                );
                                return;
                              }
                              showJobSelectionDialog(context, listOfJobs!,
                                  (result) async {
                                String? response = await EmployerService
                                    .postEmployerToEmployeeCall(
                                        context: context,
                                        jobModel: result!,
                                        employeeId:
                                            widget.userData.employeeID!);
                                if (response != null) {
                                  log("Contact : $response");
                                  setState(() {
                                    userContact = response;
                                    emp_get_contact = true;
                                  });
                                } else {
                                  log("Contact : Ni");
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                              child: const Text(
                                'Get Contact',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    if (!emp_get_contact &&
                        emp_send_interest &&
                        !user_send_interest)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showJobSelectionDialog(context, listOfJobs!,
                                  (result) async {
                                String? response = await EmployerService
                                    .postEmployerToEmployeeCall(
                                        context: context,
                                        jobModel: result!,
                                        employeeId:
                                            widget.userData.employeeID!);
                                if (response != null) {
                                  log("Contact : $response");
                                  setState(() {
                                    userContact = response;
                                    emp_get_contact = true;
                                  });
                                } else {
                                  log("Contact : Ni");
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                              child: const Text(
                                'Get Contact',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              String EnterOTP = "";

                              final result = await showDialog(
                                context: context,
                                builder: (context) {
                                  final _controller =
                                      TextEditingController(); // create a new controller
                                  return AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    content: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              'The OTP can be found in my application section of the applicant',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 0),
                                            child: PinCodeTextField(
                                              length: 4,
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.number,
                                              animationType: AnimationType.fade,
                                              pinTheme: PinTheme(
                                                shape: PinCodeFieldShape.box,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                fieldHeight: 50,
                                                fieldWidth: 40,
                                                activeFillColor:
                                                    const Color(0xAAffe4f0),
                                                inactiveColor:
                                                    const Color.fromARGB(
                                                        255, 0, 153, 218),
                                                inactiveFillColor: Colors.white,
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        239, 83, 122, 1.000),
                                                selectedColor:
                                                    const Color(0xAAFF0F7B),
                                                selectedFillColor:
                                                    const Color(0xAAFFAFD3),
                                              ),
                                              animationDuration: const Duration(
                                                  milliseconds: 300),
                                              enableActiveFill: true,
                                              controller:
                                                  _controller, // use the new controller
                                              onCompleted: (v) {
                                                EnterOTP = v;
                                                log(v);
                                              },
                                              onChanged: (value) {
                                                debugPrint(value);
                                                setState(() {
                                                  currentText = value;
                                                });
                                              },
                                              beforeTextPaste: (text) {
                                                return true;
                                              },
                                              appContext: context,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          ElevatedButton(
                                            onPressed: () async {
                                              if (listOfJobs == null ||
                                                  listOfJobs?.length == 0) {
                                                Utils.showSnackBar(context,
                                                    "No Jobs Posted Yet!");
                                                return;
                                              }
                                              showJobSelectionDialog(
                                                context,
                                                listOfJobs!,
                                                (result) async {
                                                  bool hiring =
                                                      await EmployerService
                                                          .postHiringTable(
                                                              context: context,
                                                              jobID: result!
                                                                  .jobID!,
                                                              employeeID: widget
                                                                  .userData
                                                                  .employeeID!,
                                                              otp: currentText);
                                                  if (hiring == false) {
                                                    Utils.showSnackBar(context,
                                                        "OTP Matching Error!");
                                                    Navigator.pop(context);
                                                  } else {
                                                    Navigator.pop(context);
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            HireSuccessPage(),
                                                      ),
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                            child: Text('Verify'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                              print(result);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                              child: const Text(
                                'Match OTP',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (emp_get_contact &&
                        !emp_send_interest &&
                        !user_send_interest)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                emp_send_interest = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                              child: const Text(
                                'Send Interest',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final result = await showDialog(
                                context: context,
                                builder: (context) {
                                  final _controller =
                                      TextEditingController(); // create a new controller
                                  return AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    content: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              'The OTP can be found in my application section of the applicant',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 0),
                                            child: PinCodeTextField(
                                              length: 4,
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.number,
                                              animationType: AnimationType.fade,
                                              pinTheme: PinTheme(
                                                shape: PinCodeFieldShape.box,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                fieldHeight: 50,
                                                fieldWidth: 40,
                                                activeFillColor:
                                                    const Color(0xAAffe4f0),
                                                inactiveColor:
                                                    const Color.fromARGB(
                                                        255, 0, 153, 218),
                                                inactiveFillColor: Colors.white,
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        239, 83, 122, 1.000),
                                                selectedColor:
                                                    const Color(0xAAFF0F7B),
                                                selectedFillColor:
                                                    const Color(0xAAFFAFD3),
                                              ),
                                              animationDuration: const Duration(
                                                  milliseconds: 300),
                                              enableActiveFill: true,
                                              controller:
                                                  _controller, // use the new controller
                                              onCompleted: (v) {
                                                debugPrint("Completed");
                                              },
                                              onChanged: (value) {
                                                debugPrint(value);
                                                setState(() {
                                                  currentText = value;
                                                });
                                              },
                                              beforeTextPaste: (text) {
                                                return true;
                                              },
                                              appContext: context,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HireSuccessPage(),
                                                ),
                                              );
                                            },
                                            child: Text('Verify'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                              print(result);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                              child: const Text(
                                'Match OTP',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (user_send_interest ||
                        emp_get_contact && emp_send_interest)
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "$userContact",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final result = await showDialog(
                                context: context,
                                builder: (context) {
                                  final _controller =
                                      TextEditingController(); // create a new controller
                                  return AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    content: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              'The OTP can be found in my application section of the applicant',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 0),
                                            child: PinCodeTextField(
                                              length: 4,
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.number,
                                              animationType: AnimationType.fade,
                                              pinTheme: PinTheme(
                                                shape: PinCodeFieldShape.box,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                fieldHeight: 50,
                                                fieldWidth: 40,
                                                activeFillColor:
                                                    const Color(0xAAffe4f0),
                                                inactiveColor:
                                                    const Color.fromARGB(
                                                        255, 0, 153, 218),
                                                inactiveFillColor: Colors.white,
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        239, 83, 122, 1.000),
                                                selectedColor:
                                                    const Color(0xAAFF0F7B),
                                                selectedFillColor:
                                                    const Color(0xAAFFAFD3),
                                              ),
                                              animationDuration: const Duration(
                                                  milliseconds: 300),
                                              enableActiveFill: true,
                                              controller:
                                                  _controller, // use the new controller
                                              onCompleted: (v) {
                                                debugPrint("Completed");
                                              },
                                              onChanged: (value) {
                                                debugPrint(value);
                                                setState(() {
                                                  currentText = value;
                                                });
                                              },
                                              beforeTextPaste: (text) {
                                                return true;
                                              },
                                              appContext: context,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HireSuccessPage(),
                                                ),
                                              );
                                            },
                                            child: Text('Verify'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                              print(result);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                              child: const Text(
                                'Match OTP',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    // Add any additional cases here
                  ],
                ),

                // Tab buttons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40.0,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: EdgeInsets.all(6),
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.white,
                      tabs: [
                        Tab(
                          text: 'About',
                        ),
                        Tab(
                          text: 'Experience',
                        ),
                        Tab(
                          text: 'Preference',
                        ),
                      ],
                    ),
                  ),
                ),

                // Tab views
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20.0),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(4),
                                  },
                                  children: [
                                    _buildTableRow(
                                        'Age', '${widget.userData.age}'),
                                    _buildTableRow(
                                        'Gender', '${widget.userData.gender}'),
                                    _buildTableRow('Location',
                                        '${widget.userData.city}, ${widget.userData.stateUt}'),
                                    _buildTableRow('Preferred Location',
                                        '${widget.userData.preferredCity}, ${widget.userData.preferredStateUt}'),
                                    _buildTableRow('Qualification',
                                        '${widget.userData.qualification}'),
                                    _buildTableRow('Expected Salary',
                                        '${widget.userData.expectedSalary} ${widget.userData.salaryFrequency}'),
                                    _buildTableRow('Preferred Shift', 'Day'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Spacer()
                        ],
                      ),
                      // Container(),
                      // Container(),
                      Container(
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : (listOfQualifications == null ||
                                    listOfQualifications?.length == 0)
                                ? Center(
                                    child: Text("No Experience"),
                                  )
                                : Stack(
                                    children: [
                                      SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: listOfQualifications!
                                                .map<Widget>(
                                                  (experience) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal: 32),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100.0),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 2,
                                                            blurRadius: 5,
                                                            offset: Offset(0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${experience.organization}',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                          SizedBox(height: 8.0),
                                                          Text(
                                                            '${experience.duration}',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          SizedBox(height: 8.0),
                                                          Text(
                                                            '${experience.role}',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                      ),
                      Container(
                        child: (listOfJobCategory == null ||
                                listOfJobCategory!.length == 0)
                            ? Center(
                                child: Text("No Preference Available"),
                              )
                            : Column(
                                children: listOfJobCategory!
                                    .map(
                                      (e) => JobPreferenceTile(
                                        categoryImage: e.photo!,
                                        categoryName: e.category!,
                                        number: "1",
                                      ),
                                    )
                                    .toList()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class JobSelectionDialog extends StatelessWidget {
  final List<JobModel> jobNames;
  final Function(JobModel?) onSubmit;

  JobSelectionDialog({required this.jobNames, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select the Job Post"),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: jobNames.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(jobNames[index].jobProfile ?? ""),
              onTap: () async {
                // Navigator.pop(context, jobNames[index]);
                onSubmit(jobNames[index]);
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Handle cancel button press
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}

void showJobSelectionDialog(BuildContext context, List<JobModel> jobNames,
    Function(JobModel?) onSubmit) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return JobSelectionDialog(
        jobNames: jobNames,
        onSubmit: onSubmit,
      );
    },
  );
}

class ExpInfoTile extends StatelessWidget {
  final String organization;
  final String role;
  final String duration;

  const ExpInfoTile({
    Key? key,
    required this.organization,
    required this.role,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                organization,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                role,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                duration,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class JobPreferenceTile extends StatelessWidget {
  final String categoryImage;
  final String categoryName;
  final String number;

  const JobPreferenceTile({
    Key? key,
    required this.categoryImage,
    required this.categoryName,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            width: 25.0,
            height: 25.0,
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 15.0),
          Image(
            image: AssetImage(categoryImage),
            width: 35.0,
            height: 35.0,
          ),
          SizedBox(width: 15.0),
          Text(
            categoryName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
