import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rotijugaad/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'language.dart';
import 'globals.dart';

class CustomSplashScreen extends StatefulWidget {
  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isEnglishSelect =
          prefs.getBool('isEnglishSelected') != null ? true : false;
      print(isEnglishSelect);
      //print(prefs.getBool('isEnglishSelected')!);
      if (isEnglishSelect) {
        // Language selection exists
        isEnglishSelected = prefs.getBool('isEnglishSelected')!;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LanguageSelectScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/load.png',
                  height: 400,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 16),
                child: GestureDetector(
                  onTap: () => launch('https://www.webminix.com'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Powered by ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Webminix',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
