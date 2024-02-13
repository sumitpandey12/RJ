import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'doc_upload.dart';
import 'globals.dart';

class JobPreference {
  final String title;
  final String imagePath;
  final String value;

  JobPreference(this.title, this.imagePath, this.value);
}

class JobPreferencesPage extends StatefulWidget {
  void initState() {}

  @override
  _JobPreferencesPageState createState() => _JobPreferencesPageState();
}

class _JobPreferencesPageState extends State<JobPreferencesPage> {
  List<JobPreference> _jobPreferences = [];
  @override
  void initState() {
    super.initState();
    fetchData().then((jobPreferences) {
      setState(() {
        _jobPreferences = jobPreferences;
      });
    }).catchError((error) {
      // Handle error if fetching job preferences fails
      print('Error fetching job preferences: $error');
    });
  }

  Future<List<JobPreference>> fetchData() async {
    final url = 'http://185.149.233.87:8000/api/job-categories/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;

      List<JobPreference> jobPreferences = data.map((element) {
        String categoryString = element['Category'];
        List<dynamic> categoryList =
            jsonDecode(categoryString) as List<dynamic>;
        String title = categoryList[isEnglishSelected ? 0 : 1];
        String imagePath = element['Photo'];
        String value = jsonEncode(categoryList);
        return JobPreference(title, imagePath, value);
      }).toList();

      return jobPreferences;
    } else {
      throw Exception('Failed to fetch job preferences');
    }
  }

  final List<String> _selectedPreferences = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Preferences'),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 16.0),
                  const Text(
                    'Select up to 3 Job Preferences',
                    style: TextStyle(
                      color: Color(0xFF0098DA),
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    crossAxisCount: 3,
                    padding: const EdgeInsets.all(16.0),
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    children: _jobPreferences.asMap().entries.map((entry) {
                      final preference = entry.value;
                      final index = entry.key;
                      final isSelected = _selectedPreferences.contains(
                          "{'Category' :${preference.value}, 'Photo' :${preference.imagePath}}");
                      final gradient = isSelected
                          ? const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                            )
                          : index % 2 == 0
                              ? const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF0098DA),
                                    Color(0xFF79B3F2)
                                  ],
                                )
                              : const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFFEF537A),
                                    Color(0xFFF398AF)
                                  ],
                                );

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_selectedPreferences.contains(
                                "{'Category' :${preference.value}, 'Photo' :${preference.imagePath}}")) {
                              _selectedPreferences.remove(
                                  "{'Category' :${preference.value}, 'Photo' :${preference.imagePath}}");
                            } else if (_selectedPreferences.length < 3) {
                              _selectedPreferences.add(
                                  "{'Category' :${preference.value}, 'Photo' :${preference.imagePath}}");
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: gradient,
                            borderRadius: BorderRadius.circular(15.0),
                            border: isSelected
                                ? Border.all(
                                    color: Colors.blue,
                                    width: 2.0,
                                  )
                                : null,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                preference.imagePath,
                                width: 60,
                                height: 60,
                                color: isSelected ? Colors.blue : Colors.white,
                              ),
                              const SizedBox(height: 8.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    preference.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(160, 255, 255, 255), Color(0xFFFFFFFF)],
              )),
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
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
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(136, 158, 158, 158),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(136, 158, 158, 158),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 55,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(136, 158, 158, 158),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (_selectedPreferences.isNotEmpty) {
                          print(_selectedPreferences);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDocUpload(),
                            ),
                          );
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: Colors.blue,
                          child: const Icon(
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
            ),
          ),
        ],
      ),
    );
  }
}
