import 'package:flutter/material.dart';
import 'package:rotijugaad/user_job_pref.dart';

class UserUpdateExperience extends StatefulWidget {
  @override
  _UserUpdateExperienceState createState() => _UserUpdateExperienceState();
}

class _UserUpdateExperienceState extends State<UserUpdateExperience> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _orgController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  List<Map<String, String>> _experienceList = [];
  String _selectedOption = 'Month';

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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        Map<String, String> experience = {
                          'organization': _orgController.text,
                          'role': _roleController.text,
                          'duration':
                              _durationController.text + _selectedOption,
                        };
                        _experienceList.add(experience);
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
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
