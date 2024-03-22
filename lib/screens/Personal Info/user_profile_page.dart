import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rotijugaad/APIs/employee.dart';
import 'package:rotijugaad/models/qualificationModel.dart';
import 'package:rotijugaad/screens/Personal%20Info/iser_info_test.dart';
import 'package:rotijugaad/screens/Personal%20Info/user_update_xp.dart';

import '../../models/EmployeeModel.dart';
import '../../models/JobCategoryModel.dart';
import 'user_update_personal_info.dart';

class UserProfilePage extends StatefulWidget {
  final EmployeeModel employeModel;

  const UserProfilePage({super.key, required this.employeModel});
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  EmployeeModel? employe;
  List<QualificationModel>? listOfQualifications;
  List<JobCategoryModel>? listOfJobCategory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    employe = widget.employeModel;
    getData();
  }

  getData() async {
    listOfQualifications = await EmployeeService.getEmployeeQualification();
    listOfJobCategory =
        await EmployeeService.getJobPreference(widget.employeModel.employeeID!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
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
                  'https://picsum.photos/200',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            '${employe!.name}',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                              _buildTableRow('Age', '${employe!.age}'),
                              _buildTableRow('Gender', '${employe!.gender}'),
                              _buildTableRow('Location',
                                  '${employe!.city}${employe!.stateUt}'),
                              _buildTableRow('Preferred Location',
                                  '${employe!.preferredCity}${employe!.preferredStateUt}'),
                              _buildTableRow(
                                  'Qualification', '${employe!.qualification}'),
                              _buildTableRow('Expected Salary',
                                  '${employe!.expectedSalary}${employe!.salaryFrequency}'),
                              _buildTableRow('Preferred Shift',
                                  '${employe!.preferredShift}'),
                              _buildTableRow(
                                  'Phone No.', '${employe!.contactNo}'),
                              _buildTableRow(
                                  'Aadhar No.', '${employe!.aadharNumber}'),
                              _buildTableRow('Email', '${employe!.emailID}'),
                            ],
                          ),
                        ),
                        Positioned(
                            right: 40,
                            top: 20,
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                //color: Colors.blue,
                                //size: 50,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserPersonalInfoUpdate(
                                      employee: employe,
                                    ),
                                  ),
                                );
                              },
                            ))
                      ],
                    ),
                    Spacer()
                  ],
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: Column(
                                  children: [
                                    Column(
                                      children: listOfQualifications != null
                                          ? listOfQualifications!
                                              .map(
                                                (e) => ExpInfoTile(
                                                  organization:
                                                      e.organization ??
                                                          "Orgnization Name",
                                                  role: e.role ?? "Role Name",
                                                  duration:
                                                      "${e.duration}${e.durationType}",
                                                ),
                                              )
                                              .toList()
                                          : [Text("Experience Not Added")],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                right: 30,
                                bottom: 40,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserUpdateExperience(),
                                      ),
                                    );
                                  },
                                ))
                          ],
                        ),
                      ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        child: (listOfJobCategory == null ||
                                listOfJobCategory!.length < 1)
                            ? Center(
                                child: Text("No Preference yet!"),
                              )
                            : Column(
                                children: listOfJobCategory!
                                    .map((category) => JobPreferenceTile(
                                          categoryImage: category.photo!,
                                          categoryName: category.category!,
                                          number: 1,
                                        ))
                                    .toList(),
                              ),
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
  final int number;

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
          Icon(Icons.edit),
        ],
      ),
    );
  }
}
