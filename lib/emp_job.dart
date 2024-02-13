import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rotijugaad/emp_job_view.dart';
import 'globals.dart';

class EmpJobPage extends StatefulWidget {
  @override
  _EmpJobPageState createState() => _EmpJobPageState();
}

class _EmpJobPageState extends State<EmpJobPage> {
  bool _isEnglishSelected = isEnglishSelected;

  List jobData = [];

  Future<void> getJobData() async {
    // TODO: Make API call to get job data
    // Replace the below JSON string with the actual response from the API
    String jsonString = '''
      [
        {
          "Job ID": 1,
          "Job Title": "Electrician",
          "Salary": 15000,
          "Salary Frequency": "Monthly",
          "Interest Sent": 20,
          "Interest Received": 8,
          "Vacancy Left": 2,
          "Is_Active": true,
          "image_link": "assets/category/electrician.png",
          "job_city": "Mumbai",
          "job_state": "Maharashtra"
        },
        {
          "Job ID": 2,
          "Job Title": "Carpenter",
          "Salary": 12000,
          "Salary Frequency": "Monthly",
          "Interest Sent": 15,
          "Interest Received": 5,
          "Vacancy Left": 0,
          "Is_Active": false,
          "image_link": "assets/category/carpenter.png",
          "job_city": "Delhi",
          "job_state": "Delhi"
        }
      ]
    ''';
    setState(() {
      jobData = json.decode(jsonString);
    });
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
        // Custom color for app bar
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Functionality for back button
          },
        ),
        title: Text(
          _isEnglishSelected ? 'Job Post' : 'नियुक्तियां', // Custom title text
          style: TextStyle(
            color: Colors.white, // Custom color for title text
            fontSize: 25.0, // Custom font size for title text
            fontWeight: FontWeight.w600, // Custom font weight for title text
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: jobData.length,
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
                        color: Colors.black.withOpacity(
                            jobData[index]['Is_Active'] ? 0.5 : 0.5),
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
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    height:
                                        MediaQuery.of(context).size.width / 5,
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
                                      borderRadius:
                                          BorderRadius.circular(125.0),
                                      child: Image.asset(
                                        jobData[index]['image_link'],
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    jobData[index]['Job Title'],
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
                                      '${jobData[index]['Salary']} ${jobData[index]['Salary Frequency']}',
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
                                    Expanded(
                                      child: Text(
                                        '${jobData[index]["job_city"]}, ${jobData[index]["job_state"]}',
                                        overflow: TextOverflow.ellipsis,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${jobData[index]['Interest Sent']}',
                                  style: TextStyle(fontSize: 40),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${jobData[index]['Interest Received']}',
                                  style: TextStyle(fontSize: 40),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          jobData[index]['Is_Active']
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          JobDetailsScreen(jobData[index])),
                                )
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    int? _selectedVacancy = 1;

                                    final List<int> _vacancyOptions = [
                                      1,
                                      2,
                                    ];
                                    return AlertDialog(
                                      content: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        width: double.maxFinite,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(height: 10),
                                            DropdownButtonFormField<int>(
                                              decoration: InputDecoration(
                                                labelText: _isEnglishSelected
                                                    ? "Vacancy"
                                                    : "Vacancy",
                                                border:
                                                    const UnderlineInputBorder(),
                                                labelStyle: const TextStyle(
                                                  color: Color(0xFF0098DA),
                                                ),
                                              ),
                                              value: _selectedVacancy,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _selectedVacancy = newValue;
                                                });
                                              },
                                              items: _vacancyOptions
                                                  .map((vacancy) {
                                                return DropdownMenuItem<int>(
                                                  value: vacancy,
                                                  child: Text('$vacancy'),
                                                );
                                              }).toList(),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(height: 10),
                                            GestureDetector(
                                              onTap: () {
                                                print(_selectedVacancy);
                                                print(jobData[index]
                                                    ['Job Title']);
                                              },
                                              child: Container(
                                                width: double.maxFinite,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  "Repost Job",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFF0098DA),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Center(
                            child: Text(
                              jobData[index]['Is_Active']
                                  ? 'View Job'
                                  : 'Repost Job',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      Divider(height: 20),
                      // Add more rows as needed
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: jobData[index]['Is_Active']
                      ? Text("${jobData[index]['Vacancy Left']} Vacancy Left")
                      : Container(),
                ),
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
