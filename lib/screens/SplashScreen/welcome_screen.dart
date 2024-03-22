import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotijugaad/screens/SignUp/choice_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/globals.dart';
import 'package:rotijugaad/screens/Login/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
    double height = MediaQuery.of(context).size.height;

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
                  style: const TextStyle(
                    color: Color.fromRGBO(239, 83, 122, 1.000),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
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
                  _isEnglishSelected ? "Welcome" : "स्वागत हे",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _isEnglishSelected ? "To Roti Juggad" : "रोटी जुगाड़ में",
                  style: const TextStyle(
                    color: Color.fromRGBO(239, 83, 122, 1.000),
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => login_page(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.75,
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
                      padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
                      child: Center(
                        child: Text(
                          _isEnglishSelected ? "Log In" : "लॉग इन ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
                          builder: (context) => choice_page(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.75,
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
                      padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
                      child: Center(
                        child: Text(
                          _isEnglishSelected ? "Sign Up" : "साइन अप",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          // Image
          Positioned(
            bottom: 70,
            left: 20,
            right: 20,
            child: Image.asset(
              "assets/img.png",
              height: height * 0.2,
              width: double.infinity,
            ),
          ),
          // Social icons
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebook),
                    color: Color.fromRGBO(0, 152, 218, 1.000),
                    onPressed: () {
                      print("Pressed");
                    }),
                SizedBox(width: 20),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.instagram),
                    color: Color.fromRGBO(0, 152, 218, 1.000),
                    onPressed: () {
                      print("Pressed");
                    }),
                SizedBox(width: 20),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.linkedin),
                    color: Color.fromRGBO(0, 152, 218, 1.000),
                    onPressed: () {
                      print("Pressed");
                    }),
                SizedBox(width: 20),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitter),
                    color: Color.fromRGBO(0, 152, 218, 1.000),
                    onPressed: () {
                      print("Pressed");
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
