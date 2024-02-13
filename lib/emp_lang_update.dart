import 'package:flutter/material.dart';
import 'package:rotijugaad/emp_home_page.dart';
import 'globals.dart';

class EmpUpdateLanguageSelectScreen extends StatefulWidget {
  @override
  _EmpUpdateLanguageSelectScreenState createState() =>
      _EmpUpdateLanguageSelectScreenState();
}

class _EmpUpdateLanguageSelectScreenState
    extends State<EmpUpdateLanguageSelectScreen> {
  int _selectedLanguage = 0;
  List<Map<String, dynamic>> _languages = [
    {
      "id": 0,
      "name": "English",
      "image": "assets/en.png",
    },
    {
      "id": 1,
      "name": "Hindi",
      "image": "assets/hi.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              "Select Your Language",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 100),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _languages.map((language) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLanguage = language["id"];
                          _selectedLanguage == 0
                              ? isEnglishSelected = true
                              : isEnglishSelected = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedLanguage == language["id"]
                                ? Color.fromRGBO(0, 152, 218, 1.000)
                                : Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            language["image"],
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 125),
              child: GestureDetector(
                onTap: () {
                  _selectedLanguage == 0
                      ? isEnglishSelected = true
                      : isEnglishSelected = false;
                  print(isEnglishSelected);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployerHomePage(),
                    ),
                    (route) => false,
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  child: Text(
                    'Save',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Container(
                width: double.infinity,
                child: Image.asset(
                  "assets/lang_bot.png",
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
