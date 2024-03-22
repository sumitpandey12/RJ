import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rotijugaad/APIs/employer.dart';
import 'package:rotijugaad/EmpViewUserProfilePage.dart';
import 'package:rotijugaad/models/jobModel.dart';
import '../../utils/globals.dart';

class JobDetailsScreen extends StatefulWidget {
  final JobModel job;

  JobDetailsScreen(this.job);

  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _data = [];

  Future<void> _fetchData() async {
    // Replace this with your API call to fetch the data
    String response = '''
    [
      {
        "User ID": 1,
        "Interest_sent": true,
        "Interest_received": false,
        "User_Name": "Rajesh Kumar",
        "profile_picture_link": "https://randomuser.me/api/portraits/men/32.jpg",
        "Job_preferences": [
          {
            "Preference_number": 1,
            "Job_title": "Electrician",
            "Job_image_link": "https://example.com/electrician.jpg"
          },
          {
            "Preference_number": 2,
            "Job_title": "Carpenter",
            "Job_image_link": "https://example.com/carpenter.jpg"
          }
        ],
        "Expected_salary": 15000,
        "Salary_frequency": "Monthly",
        "Preferred_City": "Mumbai",
        "Preferred_State": "Maharashtra"
      },
      {
        "User ID": 2,
        "Interest_sent": false,
        "Interest_received": true,
        "User_Name": "Seema Singh",
        "profile_picture_link": "https://randomuser.me/api/portraits/women/33.jpg",
        "Job_preferences": [
          {
            "Preference_number": 1,
            "Job_title": "Plumber",
            "Job_image_link": "https://example.com/plumber.jpg"
          },
          {
            "Preference_number": 2,
            "Job_title": "Welder",
            "Job_image_link": "https://example.com/welder.jpg"
          }
        ],
        "Expected_salary": 12000,
        "Salary_frequency": "Monthly",
        "Preferred_City": "Delhi",
        "Preferred_State": "Delhi"
      }
    ]
    ''';
    _data = List<Map<String, dynamic>>.from(json.decode(response));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job.jobProfile!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            children: [
                              Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.width / 5,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(125),
                                  border: Border.all(
                                    color: Color(0xFF0098DA),
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(125.0),
                                  child: Image.asset(
                                    widget.job.jobImage == ""
                                        ? "assets/category/electrician.png"
                                        : widget.job.jobImage!,
                                    color: Color(0xFF0098DA),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                widget.job.jobProfile!,
                                style: TextStyle(
                                    color: Color(0xFF0098DA),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 239, 83, 122),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  '${widget.job.salaryOffered} ${widget.job.frequency}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xFF0098DA),
                                ),
                                Text(
                                  '${widget.job.city}, ${widget.job.state}',
                                  style: TextStyle(
                                      color: Color(0xFF0098DA),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            String? _salary;
                            String? _frequency;

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    width: double.maxFinite,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Update Job Post"),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                onChanged: (value) {
                                                  _salary = value;
                                                },
                                                decoration: InputDecoration(
                                                  border:
                                                      UnderlineInputBorder(),
                                                  labelText: "Salary Offered",
                                                  labelStyle: const TextStyle(
                                                    color: Color(0xFF0098DA),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: DropdownButtonFormField<
                                                  String>(
                                                decoration: InputDecoration(
                                                  hintText: "Frequency",
                                                  border: InputBorder.none,
                                                  hintStyle: const TextStyle(
                                                    color: Color(0xFF0098DA),
                                                  ),
                                                ),
                                                items: [
                                                  DropdownMenuItem(
                                                      child: Text("Daily"),
                                                      value: "Daily"),
                                                  DropdownMenuItem(
                                                      child: Text("Monthly"),
                                                      value: "Monthly"),
                                                ],
                                                onChanged: (value) {
                                                  _frequency = value;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        GestureDetector(
                                          onTap: () async {
                                            if (_salary != null &&
                                                _frequency != null) {
                                              final response =
                                                  await EmployerService
                                                      .updateJobs(
                                                          widget.job,
                                                          _salary!,
                                                          _frequency!);
                                              log("$response");
                                            } else {
                                              log("Null");
                                            }
                                          },
                                          child: Container(
                                            width: double.maxFinite,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(160),
                                            ),
                                            child: Text(
                                              "Update Job Post",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        GestureDetector(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              "Delete Job",
                                              style: TextStyle(
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Color(0xFF0098DA),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(color: Colors.blue),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.all(2),
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Sent Interest",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Received Interest",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<String, dynamic> item = _data[index];
                      if (!item['Interest_sent']) {
                        return const SizedBox.shrink();
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EmpViewUserProfilePage(
                                userId: item['User ID'],
                                jobId: widget.job.jobID!,
                                empSendInterest: true,
                                userSendInterest: false,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.8),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(125),
                                            border: Border.all(
                                              color: Color(0xFF0098DA),
                                              width: 2,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(125.0),
                                            child: Image.network(
                                              '${_data[index]["profile_picture_link"]}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${_data[index]["User_Name"]}",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              "${_data[index]["Job_preferences"][0]["Job_title"]}",
                                              style: TextStyle(
                                                  color: Color(0xFF0098DA),
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 239, 83, 122),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              child: Text(
                                                '${_data[index]["Expected_salary"]} ${_data[index]["Salary_frequency"]}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,

                                            //mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Color(0xFF0098DA),
                                              ),
                                              // Text(
                                              //   '${_data[index]["Preferred_City"]}, ${_data[index]["Preferred_State"]}',
                                              //   style: TextStyle(
                                              //       color: Color(0xFF0098DA),
                                              //       fontSize: 18,
                                              //       fontWeight:
                                              //           FontWeight.w500),
                                              // ),
                                              Expanded(
                                                child: Text(
                                                  '${_data[index]["Preferred_City"]}, ${_data[index]["Preferred_State"]}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Color(0xFF0098DA),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<String, dynamic> item = _data[index];
                      if (!item['Interest_received']) {
                        return const SizedBox.shrink();
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EmpViewUserProfilePage(
                                userId: item['User ID'],
                                jobId: widget.job.jobID!,
                                empSendInterest: false,
                                userSendInterest: true,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.8),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(125),
                                            border: Border.all(
                                              color: Color(0xFF0098DA),
                                              width: 2,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(125.0),
                                            child: Image.network(
                                              '${_data[index]["profile_picture_link"]}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${_data[index]["User_Name"]}",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              "${_data[index]["Job_preferences"][0]["Job_title"]}",
                                              style: TextStyle(
                                                  color: Color(0xFF0098DA),
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 239, 83, 122),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              child: Text(
                                                '${_data[index]["Expected_salary"]} ${_data[index]["Salary_frequency"]}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,

                                            //mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Color(0xFF0098DA),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${_data[index]["Preferred_City"]}, ${_data[index]["Preferred_State"]}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Color(0xFF0098DA),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
