import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rotijugaad/APIs/employee.dart';
import 'package:rotijugaad/models/qualificationModel.dart';
import 'package:rotijugaad/screens/Personal%20Info/user_job_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExperience extends StatefulWidget {
  @override
  _AddExperienceState createState() => _AddExperienceState();
}

class _AddExperienceState extends State<AddExperience> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _orgController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  List<QualificationModel> _experienceList = [];
  String _selectedOption = 'Month';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    List<QualificationModel> data =
        await EmployeeService.getQualification() ?? [];
    setState(() {
      _experienceList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Experience'),
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _orgController,
                  decoration: InputDecoration(
                    labelText: 'Organization',
                    labelStyle: const TextStyle(
                      color: Color(0xFF0098DA),
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _roleController,
                  decoration: InputDecoration(
                    labelText: 'Role',
                    border: UnderlineInputBorder(),
                    labelStyle: const TextStyle(
                      color: Color(0xFF0098DA),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _durationController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Duration',
                          labelStyle: const TextStyle(
                            color: Color(0xFF0098DA),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    DropdownButton<String>(
                      value: _selectedOption,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedOption = newValue!;
                        });
                      },
                      items: <String>['Month', 'Year']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      QualificationModel model = QualificationModel(
                        employeeID:
                            int.parse("${pref.getString("EmployeeId")}"),
                        organization: _orgController.text,
                        duration: int.parse("${_durationController.text}"),
                        durationType: _selectedOption,
                        role: _roleController.text,
                        userID: pref.getString("Phone_No"),
                      );

                      await EmployeeService.updateExperience(
                          context: context, experience: model);

                      setState(() {
                        _experienceList.add(model);
                        _roleController.clear();
                        _durationController.clear();
                        _orgController.clear();
                      });
                    }
                    print(_experienceList);
                  },
                  child: Text('Save'),
                ),
                SizedBox(height: 10.0),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: ListView.builder(
                      itemCount: _experienceList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _experienceList[index].organization ??
                                            '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        _experienceList[index].role ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        _experienceList[index]
                                                .duration
                                                .toString() ??
                                            '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        _experienceList.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(136, 158, 158, 158),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 55,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(136, 158, 158, 158),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(136, 158, 158, 158),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        log("${_experienceList}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobPreferencesPage(),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: Colors.blue,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
      ]),
    );
  }
}
