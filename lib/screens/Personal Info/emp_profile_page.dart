import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rotijugaad/APIs/employer.dart';
import 'package:rotijugaad/APIs/endpoints.dart';
import 'package:rotijugaad/models/EmployerModel.dart';
import 'package:http/http.dart' as http;
import 'package:rotijugaad/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmpProfilePage extends StatefulWidget {
  @override
  _EmpProfilePageState createState() => _EmpProfilePageState();
}

class _EmpProfilePageState extends State<EmpProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  EmployerModel? employer;
  bool isLoading = true;
  String? _email;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getData();
  }

  void getData() async {
    employer = await EmployerService.getCurrentEmployer(context, null);
    log("Name : ${employer?.name}");
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
          Container(
            height: 200.0,
            decoration: BoxDecoration(),
            child: ClipRRect(
              child: Image.asset(
                'assets/img.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5.0),

          // Tab buttons

          // Tab views
          Expanded(
            child: Column(
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
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : employer == null
                              ? Center(
                                  child: Text("Profile not completed yet!"),
                                )
                              : Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(3),
                                    1: FlexColumnWidth(5),
                                  },
                                  children: [
                                    _buildTableRow(
                                        'Name', "${employer!.name!}"),
                                    _buildTableRow('Organization',
                                        "${employer!.organization!}"),
                                    _buildTableRow(
                                        'City', "${employer!.city!}"),
                                    _buildTableRow(
                                        'State', "${employer!.stateUt!}"),
                                    _buildTableRow('Contact No.',
                                        "${employer!.userID!.toString()}"),
                                    _buildTableRow(
                                        'Email Id', '${employer!.emailID!}'),
                                    _buildTableRow('Organization Type',
                                        '${employer!.organizationType!}'),
                                    _buildTableRow(
                                        'Address', '${employer!.address!},'),
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Container(
                                  width: double.maxFinite,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Update Email',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextField(
                                        onChanged: (value) {
                                          _email = value;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle:
                                              TextStyle(color: Colors.blue),
                                          hintText: 'Enter new email',
                                          border: UnderlineInputBorder(),
                                        ),
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (_email != null) {
                                              bool? response =
                                                  await EmployerService
                                                      .updateEmail(_email ??
                                                          "abc@gmail.com");
                                              if (response == true) {
                                                getData();
                                              }
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 20),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 20,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              'Update',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
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
                      ),
                    )
                  ],
                ),
                Spacer()
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
