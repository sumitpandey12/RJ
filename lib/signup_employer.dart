import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotijugaad/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';
import 'package:rotijugaad/otp_verify_emp.dart';
import 'package:http/http.dart' as http;

//OTPVerificationScreen_emp

String generateRandomNumber(int min, int max) {
  final random = Random();
  final randomNumber = min + random.nextInt(max - min + 1);
  return randomNumber.toString();
}

Future<void> sendSMS(String otp, String phoneNumber) async {
  final headers = {
    'accept': 'text/plain',
  };

  final params = {
    'SenderId': 'RJUGAD',
    'Message':
        'Your OTP to access RotiJugaad is $otp. It will be valid for 10 minutes. Please don\'t share with others.',
    'MobileNumbers': phoneNumber,
    'ApiKey': 'OFm4EM9yOt8oKeo4PT4DNbub+5/K+jaXZsgcGjo7+po=',
    'ClientId': '658cc1dc-4989-44c8-be6a-1b56610f0b9f',
  };

  final url = Uri.https('api.zapsms.co.in', '/api/v2/SendSMS', params);

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    // Request successful, you can handle the response here
    print('SMS sent successfully');
  } else {
    // Request failed, handle the error
    print('Failed to send SMS. Status code: ${response.statusCode}');
  }
}

bool _isPhoneNumberValid(String phoneNumber) {
  final phoneNumberRegex = RegExp(r'^[0-9]{10}$');
  return phoneNumberRegex.hasMatch(phoneNumber);
}

class signup_employer extends StatefulWidget {
  @override
  _signup_employer createState() => _signup_employer();
}

class _signup_employer extends State<signup_employer> {
  bool _isEnglishSelected = isEnglishSelected;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String? _name;
  String? _phoneNumber;
  final String _phoneCode = '+91';

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _nameController = TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isEnglishSelected ? "SIGNUP" : "साइन अप",
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
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isEnglishSelected ? "Name" : "नाम",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: _isEnglishSelected
                                    ? 'Enter your Name'
                                    : "अपना नाम दर्ज करें",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _name = value.trim();
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return _isEnglishSelected
                                      ? 'Please enter your name'
                                      : 'कृपया अपना नाम दर्ज करें';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 1.0,
                        color: const Color.fromARGB(255, 0, 153, 218),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isEnglishSelected ? "Phone No" : "फोन नंबर",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/flag.png',
                                  width: 25.0,
                                  height: 25.0,
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  _phoneCode,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              controller: _phoneController,
                              decoration: InputDecoration(
                                hintText: _isEnglishSelected
                                    ? 'Enter your phone number'
                                    : 'अपना फोन नंबर डालें',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _phoneNumber = value.trim();
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return _isEnglishSelected
                                      ? 'Please enter your phone number'
                                      : 'कृपया अपना फोन नंबर दर्ज करें';
                                }
                                if (value.length != 10 ||
                                    int.tryParse(value) == null) {
                                  return _isEnglishSelected
                                      ? 'Please enter a valid 10-digit phone number'
                                      : 'कृपया एक मान्य 10 अंकों का फोन नंबर दर्ज करें';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 1.0,
                        color: const Color.fromARGB(255, 0, 153, 218),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () async {
                    if (_name != null && _phoneNumber != null) {
                      // Both name and phone number are filled
                      if (_name!.isEmpty || _phoneNumber!.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                _isEnglishSelected ? "Error" : "त्रुटि",
                              ),
                              content: Text(
                                _isEnglishSelected
                                    ? "Please enter name and phone number"
                                    : "कृपया नाम और फ़ोन नंबर दर्ज करें",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    _isEnglishSelected ? "OK" : "ठीक है",
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Validating the name and phone number
                        if (_name!.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  _isEnglishSelected ? "Error" : "त्रुटि",
                                ),
                                content: Text(
                                  _isEnglishSelected
                                      ? "Please enter your name"
                                      : "कृपया अपना नाम दर्ज करें",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      _isEnglishSelected ? "OK" : "ठीक है",
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (_phoneNumber!.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  _isEnglishSelected ? "Error" : "त्रुटि",
                                ),
                                content: Text(
                                  _isEnglishSelected
                                      ? "Please enter your phone number"
                                      : "कृपया अपना फ़ोन नंबर दर्ज करें",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      _isEnglishSelected ? "OK" : "ठीक है",
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (!_isPhoneNumberValid(_phoneNumber!)) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  _isEnglishSelected ? "Error" : "त्रुटि",
                                ),
                                content: Text(
                                  _isEnglishSelected
                                      ? "Please enter a valid 10-digit phone number"
                                      : "कृपया एक वैध 10-अंकीय फ़ोन नंबर दर्ज करें",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      _isEnglishSelected ? "OK" : "ठीक है",
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Both name and phone number are valid

                          String otp = generateRandomNumber(1000, 9999);
                          await sendSMS(otp, _phoneNumber!);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPVerificationScreen_emp(
                                phoneNumber: _phoneNumber!,
                                otp: otp,
                                name: _name!,
                              ),
                            ),
                          );
                        }
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              _isEnglishSelected ? "Error" : "त्रुटि",
                            ),
                            content: Text(
                              _isEnglishSelected
                                  ? "Please enter name and phone number"
                                  : "कृपया नाम और फ़ोन नंबर दर्ज करें",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  _isEnglishSelected ? "OK" : "ठीक है",
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 152, 218, 1.000),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color.fromRGBO(0, 152, 218, 1.000),
                          width: 3,
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                      child: Center(
                        child: Text(
                          _isEnglishSelected ? "Get OTP" : "ओटीपी प्राप्त करें",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => login_page(),
                        ),
                      );
                    },
                    child: Text(
                      _isEnglishSelected
                          ? "Already a User? Log In"
                          : "पहले से ही इस्तेमाल करते है? लॉग इन करें",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0098DA),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF0098DA),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            // Image
            Image.asset(
              "assets/img.png",
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
            ),
            // Social icons
          ],
        ),
      ),
    );
  }
}
