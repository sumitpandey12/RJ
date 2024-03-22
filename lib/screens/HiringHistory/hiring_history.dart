import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rotijugaad/APIs/employer.dart';

import '../../models/hiringModel.dart';

class HiringHistoryPage extends StatefulWidget {
  @override
  _HiringHistoryPageState createState() => _HiringHistoryPageState();
}

class _HiringHistoryPageState extends State<HiringHistoryPage> {
  List<Map<String, dynamic>> hiringData = [];
  List<HiringModel>? listOfHiring;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    // In a future version, this data would come from an API
    List<Map<String, dynamic>> data = [
      {
        "user_id": 1,
        "user_name": "Rahul Sharma",
        "job_title": "Electrician",
        "salary": 15000,
        "salary_freq": "Monthly",
        "hired_on": "2022-03-15",
        "Aadhar": "1234 5678 9012",
        "Contact Number": "+91 9876543210",
        "profile_picture_link": "https://randomuser.me/api/portraits/men/51.jpg"
      },
      {
        "user_id": 2,
        "user_name": "Sneha Singh",
        "job_title": "Welder",
        "salary": 12000,
        "salary_freq": "Monthly",
        "hired_on": "2022-02-10",
        "Aadhar": "3456 7890 1234",
        "Contact Number": "+91 9876543211",
        "profile_picture_link":
            "https://randomuser.me/api/portraits/women/41.jpg"
      }
    ];

    listOfHiring = await EmployerService.getHiringTable(context: context);
    setState(() {
      hiringData = data;
      isLoading = false;
      log("${listOfHiring?.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiring History'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (listOfHiring == null || listOfHiring?.length == 0)
              ? const Center(
                  child: Text("No Hiring Data Availabl"),
                )
              : ListView.builder(
                  itemCount: listOfHiring?.length,
                  itemBuilder: (BuildContext context, int index) {
                    HiringModel data = listOfHiring![index];
                    return Padding(
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
                                          'https://randomuser.me/api/portraits/men/51.jpg',
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(left: 8),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "${data.candidateName}",
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "${data.jobProfile}",
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
                                            color: const Color.fromARGB(
                                                255, 239, 83, 122),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Text(
                                            '${data.salary} ${data.salaryFrequency}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 8),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Hired On: ${data.date}",
                                          style: const TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 8),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Aadhar No.: ${data.aadharNo}",
                                          style: const TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 8),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Contact No.: ${data.contactNo}",
                                          style: const TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
