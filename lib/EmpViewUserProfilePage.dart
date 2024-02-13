import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:url_launcher/url_launcher.dart';
import 'hire_complete.dart';

class EmpViewUserProfilePage extends StatefulWidget {
  final int userId;
  final int jobId;
  final bool empSendInterest;
  final bool userSendInterest;

  EmpViewUserProfilePage({
    required this.userId,
    required this.jobId,
    required this.empSendInterest,
    required this.userSendInterest,
  });

  @override
  _EmpViewUserProfilePageState createState() => _EmpViewUserProfilePageState();
}

class _EmpViewUserProfilePageState extends State<EmpViewUserProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool emp_get_contact = false;
  bool emp_send_interest = false;
  bool user_send_interest = false;
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getUserData();
    emp_send_interest = widget.empSendInterest;
    user_send_interest = widget.userSendInterest;
  }

  Future<void> getUserData() async {
    // TODO: Make API call to get user data using widget.userId and widget.jobId
    // Replace the below JSON string with the actual response from the API
    String jsonString = '''
      {
        "User ID": 1234,
        "User_Name": "John Doe",
        "Age": 30,
        "Gender": "Male",
        "City": "Mumbai",
        "State": "Maharashtra",
        "Preferred_City": "Pune",
        "Preferred_State": "Maharashtra",
        "Experience": [
            {
                "Organization": "ABC Construction Pvt Ltd",
                "Duration": "3 years",
                "Role": "Carpenter"
            },
            {
                "Organization": "XYZ Construction Pvt Ltd",
                "Duration": "2 years",
                "Role": "Mason"
            }
        ],
        "Qualification": "10th pass",
        "Expected Salary": 15000,
        "Salary Frequency": "Monthly",
        "Preferred Shift": "Day",
        "profile_picture_link": "https://randomuser.me/api/portraits/men/51.jpg",
        "contact number": "9876543210",
        "Job_preferences": [
            {
                "Preference_number": 1,
                "Job_title": "Carpenter",
                "Job_image_link": "assets/category/carpenter.png"
            },
            {
                "Preference_number": 2,
                "Job_title": "Mason",
                "Job_image_link": "assets/category/others.png"
            }
        ],
        "Profile_pin": 1234
      }
    ''';
    setState(() {
      userData = json.decode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Page'),
      ),
      body: Column(
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
                '${userData["profile_picture_link"]}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            '${userData["User_Name"]}',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!emp_get_contact && !user_send_interest && !emp_send_interest)
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          emp_get_contact = true;
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

              if (!emp_get_contact && emp_send_interest && !user_send_interest)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          emp_get_contact = true;
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
                        final result = await showDialog(
                          context: context,
                          builder: (context) {
                            final _controller =
                                TextEditingController(); // create a new controller
                            return AlertDialog(
                              backgroundColor: Colors.transparent,
                              content: Container(
                                width: MediaQuery.of(context).size.width / 1.5,
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
                                        keyboardType: TextInputType.number,
                                        animationType: AnimationType.fade,
                                        pinTheme: PinTheme(
                                          shape: PinCodeFieldShape.box,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          fieldHeight: 50,
                                          fieldWidth: 40,
                                          activeFillColor:
                                              const Color(0xAAffe4f0),
                                          inactiveColor: const Color.fromARGB(
                                              255, 0, 153, 218),
                                          inactiveFillColor: Colors.white,
                                          activeColor: const Color.fromRGBO(
                                              239, 83, 122, 1.000),
                                          selectedColor:
                                              const Color(0xAAFF0F7B),
                                          selectedFillColor:
                                              const Color(0xAAFFAFD3),
                                        ),
                                        animationDuration:
                                            const Duration(milliseconds: 300),
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
                                        if (currentText ==
                                            '${userData["Profile_pin"]}') {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HireSuccessPage(),
                                            ),
                                          );
                                        } else {}
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
              if (emp_get_contact && !emp_send_interest && !user_send_interest)
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
                                width: MediaQuery.of(context).size.width / 1.5,
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
                                        keyboardType: TextInputType.number,
                                        animationType: AnimationType.fade,
                                        pinTheme: PinTheme(
                                          shape: PinCodeFieldShape.box,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          fieldHeight: 50,
                                          fieldWidth: 40,
                                          activeFillColor:
                                              const Color(0xAAffe4f0),
                                          inactiveColor: const Color.fromARGB(
                                              255, 0, 153, 218),
                                          inactiveFillColor: Colors.white,
                                          activeColor: const Color.fromRGBO(
                                              239, 83, 122, 1.000),
                                          selectedColor:
                                              const Color(0xAAFF0F7B),
                                          selectedFillColor:
                                              const Color(0xAAFFAFD3),
                                        ),
                                        animationDuration:
                                            const Duration(milliseconds: 300),
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
                                        if (currentText ==
                                            '${userData["Profile_pin"]}') {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HireSuccessPage(),
                                            ),
                                          );
                                        } else {}
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
              if (user_send_interest || emp_get_contact && emp_send_interest)
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
                            width: MediaQuery.of(context).size.width / 1.5,
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: PinCodeTextField(
                                    length: 4,
                                    obscureText: false,
                                    keyboardType: TextInputType.number,
                                    animationType: AnimationType.fade,
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      fieldHeight: 50,
                                      fieldWidth: 40,
                                      activeFillColor: const Color(0xAAffe4f0),
                                      inactiveColor: const Color.fromARGB(
                                          255, 0, 153, 218),
                                      inactiveFillColor: Colors.white,
                                      activeColor: const Color.fromRGBO(
                                          239, 83, 122, 1.000),
                                      selectedColor: const Color(0xAAFF0F7B),
                                      selectedFillColor:
                                          const Color(0xAAFFAFD3),
                                    ),
                                    animationDuration:
                                        const Duration(milliseconds: 300),
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
                                    if (currentText ==
                                        '${userData["Profile_pin"]}') {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HireSuccessPage(),
                                        ),
                                      );
                                    } else {}
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
                              _buildTableRow('Age', Text('${userData["Age"]}')),
                              _buildTableRow(
                                  'Gender', Text(userData["Gender"])),
                              _buildTableRow(
                                  'Location',
                                  Text(
                                      '${userData["City"]}, ${userData["State"]}')),
                              _buildTableRow(
                                  'Preferred Location',
                                  Text(
                                      '${userData["Preferred_City"]}, ${userData["Preferred_State"]}')),
                              _buildTableRow('Qualification',
                                  Text('${userData["Qualification"]}')),
                              _buildTableRow(
                                  'Expected Salary',
                                  Text(
                                      '${userData["Expected Salary"]} ${userData["Salary Frequency"]}')),
                              _buildTableRow('Preferred Shift',
                                  Text('${userData["Preferred Shift"]}')),
                              if (emp_get_contact || user_send_interest)
                                _buildTableRow(
                                  'Contact',
                                  GestureDetector(
                                    onTap: () {
                                      launch(
                                          "tel://${userData["contact number"]}");
                                    },
                                    child: Text(
                                      '${userData["contact number"]}',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer()
                  ],
                ),
                Container(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: userData["Experience"]
                                .map<Widget>(
                                  (experience) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 32),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${experience["Organization"]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            '${experience["Duration"]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            '${experience["Role"]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
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
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: userData["Job_preferences"]
                            .map<Widget>(
                              (Job_preferences) => JobPreferenceTile(
                                categoryImage:
                                    '${Job_preferences["Job_image_link"]}',
                                categoryName: '${Job_preferences["Job_title"]}',
                                number:
                                    '${Job_preferences["Preference_number"]}',
                              ),
                            )
                            .toList(),
                      ),

                      // Add two more similar containers here
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String label, Widget value) {
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
          child: value,
        ),
      ],
    );
  }
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
