import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rotijugaad/APIs/employer.dart';
import 'package:rotijugaad/APIs/endpoints.dart';
import 'package:rotijugaad/screens/Home/emp_home_page.dart';
import 'package:rotijugaad/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/globals.dart';

import 'package:http/http.dart' as http;

class OTPVerificationScreen_emp extends StatefulWidget {
  final String phoneNumber;
  final String otp;
  final String name;
  const OTPVerificationScreen_emp(
      {super.key,
      required this.phoneNumber,
      required this.otp,
      required this.name});

  @override
  _OTPVerificationScreen_emp createState() => _OTPVerificationScreen_emp();
}

class _OTPVerificationScreen_emp extends State<OTPVerificationScreen_emp> {
  bool _isEnglishSelected = isEnglishSelected;
  String _buttonText = "English Button";
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  final String _phoneCode = '+91';
  int _start = 60;
  late Timer _timer;
  bool _isButtonDisabled = false;
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start == 0) {
          _timer.cancel();
          _isButtonDisabled = false;
        } else {
          _start--;
        }
      });
    });
  }

  void resetTimer() {
    setState(() {
      _start = 60;
    });
  }

  @override
  void initState() {
    startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isEnglishSelected
              ? 'OTP sent successfully to ${widget.phoneNumber}'
              : 'ओटीपी सफलतापूर्वक ${widget.phoneNumber} पर भेजा गया'),
          duration: Duration(seconds: 5),
        ),
      );
    });
    super.initState();
  }

  void _toggleLanguage() async {
    setState(() {
      _isEnglishSelected = !_isEnglishSelected;
      isEnglishSelected = _isEnglishSelected;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isEnglishSelected', _isEnglishSelected);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isEnglishSelected ? "Verify\nOTP" : "ओटीपी\nमिलान",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
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
                        activeTrackColor:
                            const Color.fromRGBO(239, 83, 122, 1.000),
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor:
                            const Color.fromRGBO(239, 83, 122, 1.000),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _isEnglishSelected ? "Enter OTP" : "ओटीपी दर्ज करें",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 153, 218)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: PinCodeTextField(
                    length: 4,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: const Color(0xAAffe4f0),
                      inactiveColor: const Color.fromARGB(255, 0, 153, 218),
                      inactiveFillColor: Colors.white,
                      activeColor: const Color.fromRGBO(239, 83, 122, 1.000),
                      selectedColor: const Color(0xAAFF0F7B),
                      selectedFillColor: const Color(0xAAFFAFD3),
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: textEditingController,
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                    appContext: context,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _isEnglishSelected
                          ? "$_start seconds left"
                          : "$_start सेकंड शेष",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF05CF01)),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_start > 0) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(_isEnglishSelected
                                ? "Wait for $_start seconds to send OTP again"
                                : "दोबारा ओटीपी भेजने से पहले $_start सेकंड तक प्रतीक्षा करें"),
                          ),
                        );
                      } else {
                        print(widget.phoneNumber);
                        _isButtonDisabled = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_isEnglishSelected
                                ? 'OTP Sent to ${widget.phoneNumber}'
                                : 'ओटीपी ${widget.phoneNumber} पर भेजा गया'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                        resetTimer();
                        startTimer();
                      }
                    },
                    child: Text(
                      _isEnglishSelected
                          ? "Not Received Yet? Resend OTP"
                          : "अभी तक नहीं मिला? ओटीपी पुनः भेजें",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0098DA),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF0098DA),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 50, top: 10),
                  child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        _isEnglishSelected
                            ? "${widget.otp} By entering the platform you agree to our Terms and Conditions"
                            : "ओटीपी दर्ज करके,आप हमारे नियमों और शर्तों से सहमत होते हैं।",
                        style: const TextStyle(
                          color: Color(0xFF636363),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 50, top: 10),
                  child: GestureDetector(
                      onTap: () {
                        if (currentText != widget.otp) {
                          Utils.showSnackBar(context, "OTP is incorrect");
                          return;
                        }
                        Utils.showSnackBar(context, "OTP Verified");
                        EmployerService.registerUser(context, widget.name,
                            widget.phoneNumber, "Employer");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        //height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(
                              0, 152, 218, 1.000), // set fill color
                          borderRadius: BorderRadius.circular(
                              30), // set border radius to create capsule shape
                          border: Border.all(
                            color: const Color.fromRGBO(
                                0, 152, 218, 1.000), // set border color
                            width: 3,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                        child: Center(
                          child: Text(
                            _isEnglishSelected ? "Verify" : "मिलान करें",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
            // Image
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            // Image
            Image.asset(
              "assets/img.png",
              height: Responsive.height(context) * 0.2,
              width: double.infinity,
            ),
            // Social icons
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
