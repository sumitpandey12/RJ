import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:rotijugaad/screens/Home/emp_home_page.dart';
import 'package:rotijugaad/screens/Home/user_home_page.dart';
import 'package:rotijugaad/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/globals.dart';

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

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String otp;
  final String accountType;
  const OTPVerificationScreen(
      {super.key,
      required this.phoneNumber,
      required this.otp,
      required this.accountType});

  @override
  _OTPVerificationScreen createState() => _OTPVerificationScreen();
}

class _OTPVerificationScreen extends State<OTPVerificationScreen> {
  bool _isEnglishSelected = isEnglishSelected;
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
            Spacer(),
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
                SizedBox(
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
                    onCompleted: (value) {
                      if (value == widget.otp) {
                        // PIN code matches the OTP
                        debugPrint("PIN code matched!");
                      } else {
                        // PIN code does not match the OTP
                        debugPrint("PIN code did not match!");
                      }
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
                    onTap: () async {
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
                        await sendSMS(widget.otp, widget.phoneNumber);
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
                            ? "${widget.otp} entering the platform you agree to our Terms and Conditions"
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
                  padding: const EdgeInsets.only(left: 50, top: 10),
                  child: GestureDetector(
                      onTap: () {
                        if (widget.otp == textEditingController.text) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      widget.accountType == "Employer"
                                          ? EmployerHomePage()
                                          : UserHomePage()),
                              (Route<dynamic> route) => false);
                        } else {
                          Utils.showSnackBar(context, "OTP not matched!");
                        }
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
              height: MediaQuery.of(context).size.height / 2.5,
              width: double.infinity,
            ),
            // Social icons
          ],
        ),
      ),
    );
  }
}
