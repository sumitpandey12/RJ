import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rotijugaad/screens/SplashScreen/welcome_screen.dart';
import '../../utils/globals.dart';

class LanguageSelectScreen extends StatefulWidget {
  @override
  _LanguageSelectScreenState createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
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
  void initState() {
    super.initState();
    _loadLanguageSelection();
  }

  void _loadLanguageSelection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEnglishSelected = prefs.getBool('isEnglishSelected') ?? true;
    setState(() {
      isEnglishSelected ? isEnglishSelected = true : isEnglishSelected = false;
    });
  }

  void _saveLanguageSelection(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isEnglishSelected', value);
    setState(() {
      value ? isEnglishSelected = true : isEnglishSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            // Check if the swipe direction is up
            if (details.primaryVelocity != null &&
                details.primaryVelocity! < 0) {
              // Navigate to the next screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                "Select Your Language",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _languages.map((language) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLanguage = language["id"];
                      });
                      _saveLanguageSelection(_selectedLanguage == 0);
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
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Container(
                  width: double.infinity,
                  child: Image.asset(
                    "assets/up.png",
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
