import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rotijugaad/screens/Personal%20Info/user_job_pref.dart';
import 'package:rotijugaad/screens/Personal%20Info/user_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../APIs/employee.dart';
import '../../models/qualificationModel.dart';

class UserUpdateExperience extends StatefulWidget {
  @override
  _UserUpdateExperienceState createState() => _UserUpdateExperienceState();
}

class _UserUpdateExperienceState extends State<UserUpdateExperience> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Experience'),
      ),
      body: Stack(
        children: [
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
                        Navigator.pop(context);
                      }
                      print(_experienceList);
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
