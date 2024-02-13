import 'package:flutter/material.dart';
import 'package:rotijugaad/signup_employer.dart';
import 'package:rotijugaad/signup_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';

class choice_page extends StatefulWidget {
  @override
  _choice_page createState() => _choice_page();
}

class _choice_page extends State<choice_page> {
  bool _isEnglishSelected = isEnglishSelected;

  void _toggleLanguage() async {
    setState(() {
      _isEnglishSelected = !_isEnglishSelected;
      isEnglishSelected = _isEnglishSelected;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isEnglishSelected', _isEnglishSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            "assets/bg.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          // Language toggle switch
          Positioned(
            top: 40,
            right: 20,
            child: Row(
              children: [
                Text(
                  _isEnglishSelected ? "EN" : "HI",
                  style: TextStyle(
                    color: Color.fromRGBO(239, 83, 122, 1.000),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Switch(
                  value: _isEnglishSelected,
                  onChanged: (value) => _toggleLanguage(),
                  activeColor: Colors.white,
                  activeTrackColor: Color.fromRGBO(239, 83, 122, 1.000),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Color.fromRGBO(239, 83, 122, 1.000),
                ),
              ],
            ),
          ),
          // Text and buttons
          Positioned(
            top: 160,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Text(
                  _isEnglishSelected ? "Are You ?" : "क्या आप:",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 60),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => signup_user(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 14,
                      decoration: BoxDecoration(
                        color: Colors.white, // set fill color
                        borderRadius: BorderRadius.circular(
                            30), // set border radius to create capsule shape
                        border: Border.all(
                          color: Color.fromRGBO(
                              0, 152, 218, 1.000), // set border color
                          width: 3,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _isEnglishSelected
                                ? "Searching For a JOB"
                                : "नौकरी खोज रहे है? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )),
                SizedBox(height: 10),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => signup_employer(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 14,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(
                            0, 152, 218, 1.000), // set fill color
                        borderRadius: BorderRadius.circular(
                            30), // set border radius to create capsule shape
                        border: Border.all(
                          color: Color.fromRGBO(
                              0, 152, 218, 1.000), // set border color
                          width: 3,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _isEnglishSelected
                                ? "Searching For a STAFF"
                                : "कर्मचारी खोज रहे है?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          // Image
          Positioned(
            bottom: 85,
            left: 20,
            right: 20,
            child: Image.asset(
              "assets/img.png",
              height: 200,
              width: double.infinity,
            ),
          ),
          // Social icons
        ],
      ),
    );
  }
}
