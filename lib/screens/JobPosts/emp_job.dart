import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:rotijugaad/APIs/employer.dart';
import 'package:rotijugaad/screens/JobPosts/emp_job_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/jobModel.dart';
import '../../utils/globals.dart';

class EmpJobPage extends StatefulWidget {
  @override
  _EmpJobPageState createState() => _EmpJobPageState();
}

class _EmpJobPageState extends State<EmpJobPage> {
  bool _isEnglishSelected = isEnglishSelected;

  List<JobModel>? listOfJobs;
  bool isLoading = true;

  Future<void> getJobData() async {
    listOfJobs = await EmployerService.getJobsByID();
    setState(() {
      isLoading = false;
    });
    log("Length: ${listOfJobs!.length}");
  }

  @override
  void initState() {
    super.initState();
    getJobData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0098DA),
        title: Text(
          _isEnglishSelected ? 'Job Post' : 'नियुक्तियां', // Custom title text
          style: TextStyle(
            color: Colors.white, // Custom color for title text
            fontSize: 25.0, // Custom font size for title text
            fontWeight: FontWeight.w600, // Custom font weight for title text
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (listOfJobs == null || listOfJobs!.length == 0)
              ? Center(
                  child: Text("No Jobs Posted!"),
                )
              : ListView.builder(
                  itemCount: listOfJobs!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              padding: EdgeInsets.all(12),
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
                                                    BorderRadius.circular(
                                                        125.0),
                                                child: Image.asset(
                                                  listOfJobs![index].jobImage ==
                                                          ""
                                                      ? "assets/category/electrician.png"
                                                      : listOfJobs![index]
                                                          .jobImage!,
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
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text(
                                              listOfJobs![index].jobProfile ??
                                                  "Job Profile",
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
                                                color: Color.fromARGB(
                                                    255, 239, 83, 122),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              child: Text(
                                                '${listOfJobs![index].salaryOffered} ${listOfJobs![index].frequency}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Color(0xFF0098DA),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${listOfJobs![index].city}, ${listOfJobs![index].state}',
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
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${listOfJobs![index].sentInterests}',
                                            style: TextStyle(fontSize: 40),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Sent',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Text(
                                                'Interests',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${listOfJobs![index].receivedInterests}',
                                            style: TextStyle(fontSize: 40),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Received',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Text(
                                                'Interests',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              JobDetailsScreen(
                                                  listOfJobs![index])),
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0098DA),
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'View Job',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(height: 20),
                                // Add more rows as needed
                              ],
                            ),
                          ),
                          // Positioned(
                          //   top: 10,
                          //   right: 10,
                          //   child: jobData[index]['Is_Active']
                          //       ? Text(
                          //           "${jobData[index]['Vacancy Left']} Vacancy Left")
                          //       : Container(),
                          // ),
                        ],
                      ),
                    );

                    // ListTile(
                    //   title: Text(jobData[index]['Job Title']),
                    //   subtitle: Text(jobData[index]['job_city']),
                    //   onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => JobDetailsScreen(jobData[index])),
                    // );
                    //   },
                    // );
                  },
                ),
    );
  }
}
