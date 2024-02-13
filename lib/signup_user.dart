import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotijugaad/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';
import 'package:rotijugaad/otp_verify_user.dart';

class signup_user extends StatefulWidget {
  @override
  _signup_user createState() => _signup_user();
}

class _signup_user extends State<signup_user> {
  bool _isEnglishSelected = isEnglishSelected;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
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
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                                hintText: isEnglishSelected
                                    ? 'Enter your Name'
                                    : "अपना नाम दर्ज करें",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
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
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OTPVerificationScreen_user(
                            phoneNumber: '9897310064',
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
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
                        padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                        child: Center(
                          child: Text(
                            _isEnglishSelected
                                ? "Get OTP"
                                : "ओटीपी प्राप्त करें",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )),
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
