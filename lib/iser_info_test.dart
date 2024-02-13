import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rotijugaad/user_add_xp.dart';

import 'globals.dart';

class UserPersonalInfoPage extends StatefulWidget {
  @override
  _UserPersonalInfoPageState createState() => _UserPersonalInfoPageState();
}

class _UserPersonalInfoPageState extends State<UserPersonalInfoPage> {
  List<String> _referredbyoptions = [];
  @override
  void initState() {
    super.initState();
    fetchData().then((referredbyoption) {
      setState(() {
        _referredbyoptions = referredbyoption;
      });
    }).catchError((error) {
      // Handle error if fetching job preferences fails
      print('Error fetching job preferences: $error');
    });
  }

  Future<List<String>> fetchData() async {
    const url = 'https://41d7-49-37-151-170.ngrok-free.app/api/referred-by/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;

      List<String> referredbyoption = data.map((element) {
        String categoryString = element['Referrer_Name'];
        List<dynamic> categoryList =
            jsonDecode(categoryString) as List<dynamic>;
        String title = categoryList[isEnglishSelected ? 0 : 1];
        return title;
      }).toList();

      return referredbyoption;
    } else {
      throw Exception('Failed to fetch job preferences');
    }
  }

  final _formKey = GlobalKey<FormState>();
  late int _age;
  bool _isMaleSelected = false;
  bool _isFemaleSelected = false;
  bool _isOtherSelected = false;
  String? _selectedOption1;
  String? _selectedOption2;
  String? _prefstate;
  String? _email;
  String? _prefcity;
  String? dropdownValue;
  final bool _isEnglishSelected = isEnglishSelected;
  String? _referredby;
  String? _qualification;
  String? _salfreq;
  String? _prefshift;

  final List<String> _qualificationoptions = [
    isEnglishSelected ? '8th or Less' : '8th या उससे कम',
    isEnglishSelected ? '9th or above' : '9th या उससे ऊपर',
    isEnglishSelected ? '12th or above' : '12th या उससे ऊपर',
    isEnglishSelected ? 'Graduation & above' : 'ग्रेजुएशन या उससे ऊपर',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Info'),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: _isEnglishSelected ? "Age" : "आयु",
                              border: const UnderlineInputBorder(),
                              labelStyle: const TextStyle(
                                color: Color(0xFF0098DA),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Age is required';
                              }
                              final age = int.tryParse(value);
                              if (age == null) {
                                return 'Please enter a valid age';
                              }
                              if (age < 18) {
                                return 'You must be 18 or above to apply';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _age = int.parse(value!);
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                _isEnglishSelected ? "Gender" : "लिंग",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isMaleSelected = true;
                                        _isFemaleSelected = false;
                                        _isOtherSelected = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _isMaleSelected
                                            ? Colors.blue
                                            : Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      child: Text(
                                        _isEnglishSelected ? 'Male' : 'नर',
                                        style: TextStyle(
                                          color: _isMaleSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isMaleSelected = false;
                                        _isFemaleSelected = true;
                                        _isOtherSelected = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _isFemaleSelected
                                            ? Colors.blue
                                            : Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      child: Text(
                                        _isEnglishSelected ? 'Female' : 'महिला',
                                        style: TextStyle(
                                          color: _isFemaleSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isMaleSelected = false;
                                        _isFemaleSelected = false;
                                        _isOtherSelected = true;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _isOtherSelected
                                            ? Colors.blue
                                            : Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      child: Text(
                                        _isEnglishSelected ? 'Other' : 'अन्य',
                                        style: TextStyle(
                                          color: _isOtherSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: _isEnglishSelected
                          ? "State / Union Territory"
                          : "राज्य / केंद्र शासित प्रदेश",
                      border: const UnderlineInputBorder(),
                      labelStyle: const TextStyle(
                        color: Color(0xFF0098DA),
                      ),
                    ),
                    value: _selectedOption1,
                    items: state_ut_list,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption1 = value;
                        _selectedOption2 =
                            null; // reset option 2 when option 1 changes
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  if (_selectedOption1 != null)
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: _isEnglishSelected ? "City" : "शहर",
                        border: const UnderlineInputBorder(),
                        labelStyle: const TextStyle(
                          color: Color(0xFF0098DA),
                        ),
                      ),
                      value: _selectedOption2,
                      items: _City_List(_selectedOption1!),
                      onChanged: (value) {
                        setState(() {
                          _selectedOption2 = value;
                        });
                      },
                    ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: _isEnglishSelected ? "Referred By" : "सहायक ",
                      border: const UnderlineInputBorder(),
                      labelStyle: const TextStyle(
                        color: Color(0xFF0098DA),
                      ),
                    ),
                    value: _referredby,
                    onChanged: (newValue) {
                      setState(() {
                        _referredby = newValue;
                      });
                    },
                    items: _referredbyoptions.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText:
                          _isEnglishSelected ? "Qualification" : "योग्यता",
                      border: const UnderlineInputBorder(),
                      labelStyle: const TextStyle(
                        color: Color(0xFF0098DA),
                      ),
                    ),
                    value: _qualification,
                    onChanged: (newValue) {
                      setState(() {
                        _qualification = newValue;
                      });
                    },
                    items: _qualificationoptions.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width * .45,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: _isEnglishSelected
                                    ? "Expected Salary"
                                    : "अपेक्षित वेतन",
                                border: const UnderlineInputBorder(),
                                labelStyle: const TextStyle(
                                  color: Color(0xFF0098DA),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: _isEnglishSelected
                                  ? "Salary Frequency"
                                  : "वेतन आवृत्ति",
                              border: const UnderlineInputBorder(),
                              labelStyle: const TextStyle(
                                color: Color(0xFF0098DA),
                              ),
                            ),
                            value: _salfreq,
                            items: [
                              DropdownMenuItem(
                                  child: Text(
                                      isEnglishSelected ? 'Monthly' : 'Daily'),
                                  value: 'Monthly'),
                              DropdownMenuItem(
                                  child:
                                      Text(isEnglishSelected ? 'Daily' : 'रोज'),
                                  value: 'Daily'),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _salfreq = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: _isEnglishSelected
                          ? "Preferred Shift"
                          : "पसंदीदा शिफ्ट",
                      border: const UnderlineInputBorder(),
                      labelStyle: const TextStyle(
                        color: Color(0xFF0098DA),
                      ),
                    ),
                    value: _prefshift,
                    items: [
                      DropdownMenuItem(
                          child: Text(isEnglishSelected ? 'Day' : 'दिन'),
                          value: 'Day'),
                      DropdownMenuItem(
                          child: Text(isEnglishSelected ? 'Night' : 'रात'),
                          value: 'Night'),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _prefshift = value;
                      });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: _isEnglishSelected
                          ? "Preferred State / Union Territory"
                          : "पसंदीदा राज्य / केंद्र शासित प्रदेश",
                      border: const UnderlineInputBorder(),
                      labelStyle: const TextStyle(
                        color: Color(0xFF0098DA),
                      ),
                    ),
                    value: _prefstate,
                    items: state_ut_list,
                    onChanged: (value) {
                      setState(() {
                        _prefstate = value;
                        _prefcity =
                            null; // reset option 2 when option 1 changes
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  if (_prefstate != null)
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: _isEnglishSelected
                            ? "Preferred City"
                            : "पसंदीदा शहर",
                        border: const UnderlineInputBorder(),
                        labelStyle: const TextStyle(
                          color: Color(0xFF0098DA),
                        ),
                      ),
                      value: _prefcity,
                      items: _City_List(_prefstate!),
                      onChanged: (value) {
                        setState(() {
                          _prefcity = value;
                        });
                      },
                    ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: _isEnglishSelected ? "Email ID" : "ईमेल आईडी",
                      border: const UnderlineInputBorder(),
                      labelStyle: const TextStyle(
                        color: Color(0xFF0098DA),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
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
                                width: 55,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(136, 158, 158, 158),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(136, 158, 158, 158),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(136, 158, 158, 158),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddExperience(),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              height: 30.0,
                              width: 30.0,
                              color: Colors.blue,
                              child: Icon(
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
                ))
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get state_ut_list {
    return [
      DropdownMenuItem(
        value: 'Andhra Pradesh',
        child: Text(_isEnglishSelected ? 'Andhra Pradesh' : 'आन्ध्र प्रदेश'),
      ),
      DropdownMenuItem(
        value: 'Arunachal Pradesh',
        child:
            Text(_isEnglishSelected ? 'Arunachal Pradesh' : 'अरुणाचल प्रदेश'),
      ),
      DropdownMenuItem(
        value: 'Assam',
        child: Text(_isEnglishSelected ? 'Assam' : 'असम'),
      ),
      DropdownMenuItem(
        value: 'Bihar',
        child: Text(_isEnglishSelected ? 'Bihar' : 'बिहार'),
      ),
      DropdownMenuItem(
        value: 'Chhattisgarh',
        child: Text(_isEnglishSelected ? 'Chhattisgarh' : 'छत्तीसगढ़'),
      ),
      DropdownMenuItem(
        value: 'Goa',
        child: Text(_isEnglishSelected ? 'Goa' : 'गोवा'),
      ),
      DropdownMenuItem(
        value: 'Gujarat',
        child: Text(_isEnglishSelected ? 'Gujarat' : 'गुजरात'),
      ),
      DropdownMenuItem(
        value: 'Haryana',
        child: Text(_isEnglishSelected ? 'Haryana' : 'हरियाणा'),
      ),
      DropdownMenuItem(
        value: 'Himachal Pradesh',
        child: Text(_isEnglishSelected ? 'Himachal Pradesh' : 'हिमाचल प्रदेश'),
      ),
      DropdownMenuItem(
        value: 'Jharkhand',
        child: Text(_isEnglishSelected ? 'Jharkhand' : 'झारखंड'),
      ),
      DropdownMenuItem(
        value: 'Karnataka',
        child: Text(_isEnglishSelected ? 'Karnataka' : 'कर्नाटक'),
      ),
      DropdownMenuItem(
        value: 'Kerala',
        child: Text(_isEnglishSelected ? 'Kerala' : 'केरल'),
      ),
      DropdownMenuItem(
        value: 'Madhya Pradesh',
        child: Text(_isEnglishSelected ? 'Madhya Pradesh' : 'मध्य प्रदेश'),
      ),
      DropdownMenuItem(
        value: 'Maharashtra',
        child: Text(_isEnglishSelected ? 'Maharashtra' : 'महाराष्ट्र'),
      ),
      DropdownMenuItem(
        value: 'Manipur',
        child: Text(_isEnglishSelected ? 'Manipur' : 'मणिपुर'),
      ),
      DropdownMenuItem(
        value: 'Meghalaya',
        child: Text(_isEnglishSelected ? 'Meghalaya' : 'मेघालय'),
      ),
      DropdownMenuItem(
        value: 'Mizoram',
        child: Text(_isEnglishSelected ? 'Mizoram' : 'मिजोरम'),
      ),
      DropdownMenuItem(
        value: 'Nagaland',
        child: Text(_isEnglishSelected ? 'Nagaland' : 'नागालैंड'),
      ),
      DropdownMenuItem(
        value: 'Odisha',
        child: Text(_isEnglishSelected ? 'Odisha' : 'ओड़िशा'),
      ),
      DropdownMenuItem(
        value: 'Punjab',
        child: Text(_isEnglishSelected ? 'Punjab' : 'पंजाब'),
      ),
      DropdownMenuItem(
        value: 'Rajasthan',
        child: Text(_isEnglishSelected ? 'Rajasthan' : 'राजस्थान'),
      ),
      DropdownMenuItem(
        value: 'Sikkim',
        child: Text(_isEnglishSelected ? 'Sikkim' : 'सिक्किम'),
      ),
      DropdownMenuItem(
        value: 'Tamil Nadu',
        child: Text(_isEnglishSelected ? 'Tamil Nadu' : 'तमिलनाडु'),
      ),
      DropdownMenuItem(
        value: 'Telangana',
        child: Text(_isEnglishSelected ? 'Telangana' : 'तेलंगाना'),
      ),
      DropdownMenuItem(
        value: 'Tripura',
        child: Text(_isEnglishSelected ? 'Tripura' : 'त्रिपुरा'),
      ),
      DropdownMenuItem(
        value: 'Uttar Pradesh',
        child: Text(_isEnglishSelected ? 'Uttar Pradesh' : 'उत्तर प्रदेश'),
      ),
      DropdownMenuItem(
        value: 'Uttarakhand',
        child: Text(_isEnglishSelected ? 'Uttarakhand' : 'उत्तराखंड'),
      ),
      DropdownMenuItem(
        value: 'West Bengal',
        child: Text(_isEnglishSelected ? 'West Bengal' : 'पश्चिम बंगाल'),
      ),
      DropdownMenuItem(
        value: 'Andaman and Nicobar',
        child:
            Text(_isEnglishSelected ? 'Andaman and Nicobar' : 'अंडमान निकोबार'),
      ),
      DropdownMenuItem(
        value: 'Chandigarh',
        child: Text(_isEnglishSelected ? 'Chandigarh' : 'चंडीगढ़'),
      ),
      DropdownMenuItem(
        value: 'Jammu and Kashmir ',
        child:
            Text(_isEnglishSelected ? 'Jammu and Kashmir ' : 'जम्मू-कश्मीर '),
      ),
      DropdownMenuItem(
        value: 'Delhi',
        child: Text(_isEnglishSelected ? 'Delhi' : 'दिल्ली'),
      ),
      DropdownMenuItem(
        value: 'Puducherry',
        child: Text(_isEnglishSelected ? 'Puducherry' : 'पुडुचेरी'),
      ),
      DropdownMenuItem(
        value: 'Ladakh',
        child: Text(_isEnglishSelected ? 'Ladakh' : 'लद्दाख'),
      ),
      DropdownMenuItem(
        value: 'Lakshadweep',
        child: Text(_isEnglishSelected ? 'Lakshadweep' : 'लक्षद्वीप'),
      ),
    ];
  }

  List<DropdownMenuItem<String>> _City_List(String selectedOption) {
    switch (selectedOption) {
      case 'Andhra Pradesh':
        return [
          DropdownMenuItem(
            value: 'Anantapur',
            child: Text(_isEnglishSelected ? 'Anantapur' : 'अनंतपुर'),
          ),
          DropdownMenuItem(
            value: 'Chittoor',
            child: Text(_isEnglishSelected ? 'Chittoor' : 'चित्तूर'),
          ),
          DropdownMenuItem(
            value: 'East Godavari',
            child:
                Text(_isEnglishSelected ? 'East Godavari' : 'पूर्वी गोदावरी'),
          ),
          DropdownMenuItem(
            value: 'Guntur',
            child: Text(_isEnglishSelected ? 'Guntur' : 'गुंटूर'),
          ),
          DropdownMenuItem(
            value: 'Kadapa',
            child: Text(_isEnglishSelected ? 'Kadapa' : 'कडपा'),
          ),
          DropdownMenuItem(
            value: 'Krishna',
            child: Text(_isEnglishSelected ? 'Krishna' : 'कृष्णा'),
          ),
          DropdownMenuItem(
            value: 'Kurnool',
            child: Text(_isEnglishSelected ? 'Kurnool' : 'कुरनूल'),
          ),
          DropdownMenuItem(
            value: 'Prakasam',
            child: Text(_isEnglishSelected ? 'Prakasam' : 'प्रकाशम'),
          ),
          DropdownMenuItem(
            value: 'Sri Potti Sriramulu Nellore',
            child: Text(_isEnglishSelected
                ? 'Sri Potti Sriramulu Nellore'
                : 'श्री पोट्टि श्रीरामुलु नेल्लोर'),
          ),
        ];
      case 'Arunachal Pradesh':
        return [
          DropdownMenuItem(
            value: 'Anjaw',
            child: Text(_isEnglishSelected ? 'Anjaw' : 'अंजाज'),
          ),
          DropdownMenuItem(
            value: 'Changlang',
            child: Text(_isEnglishSelected ? 'Changlang' : 'चांगलांग'),
          ),
          DropdownMenuItem(
            value: 'East Kameng',
            child: Text(_isEnglishSelected ? 'East Kameng' : 'ईस्ट कामेंग'),
          ),
          DropdownMenuItem(
            value: 'East Siang',
            child: Text(_isEnglishSelected ? 'East Siang' : 'पूर्वी सियांग'),
          ),
          DropdownMenuItem(
            value: 'Kamle',
            child: Text(_isEnglishSelected ? 'Kamle' : 'कामले'),
          ),
          DropdownMenuItem(
            value: 'Kra Daadi',
            child: Text(_isEnglishSelected ? 'Kra Daadi' : 'केआरए दाड़ी'),
          ),
          DropdownMenuItem(
            value: 'Kurung Kumey',
            child: Text(_isEnglishSelected ? 'Kurung Kumey' : 'कुरुंग कुमी'),
          ),
          DropdownMenuItem(
            value: 'Lepa Rada',
            child: Text(_isEnglishSelected ? 'Lepa Rada' : 'लेपा राडा'),
          ),
          DropdownMenuItem(
            value: 'Lohit',
            child: Text(_isEnglishSelected ? 'Lohit' : 'लोहित'),
          ),
          DropdownMenuItem(
            value: 'Longding',
            child: Text(_isEnglishSelected ? 'Longding' : 'लालसा'),
          ),
          DropdownMenuItem(
            value: 'Lower Dibang Valley',
            child: Text(_isEnglishSelected
                ? 'Lower Dibang Valley'
                : 'लोअर डिबांग घाटी'),
          ),
          DropdownMenuItem(
            value: 'Lower Siang',
            child: Text(_isEnglishSelected ? 'Lower Siang' : 'लोअर सियांग'),
          ),
          DropdownMenuItem(
            value: 'Lower Subansiri',
            child:
                Text(_isEnglishSelected ? 'Lower Subansiri' : 'लोअर सुभानसिरी'),
          ),
          DropdownMenuItem(
            value: 'Namsai',
            child: Text(_isEnglishSelected ? 'Namsai' : 'नामसाई'),
          ),
          DropdownMenuItem(
            value: 'Pakke-Kessang',
            child: Text(_isEnglishSelected ? 'Pakke-Kessang' : 'पक्के-केसांग'),
          ),
          DropdownMenuItem(
            value: 'Papum Pare',
            child: Text(_isEnglishSelected ? 'Papum Pare' : 'पपम परे'),
          ),
          DropdownMenuItem(
            value: 'Shi Yomi',
            child: Text(_isEnglishSelected ? 'Shi Yomi' : 'शी यामी'),
          ),
          DropdownMenuItem(
            value: 'Siang',
            child: Text(_isEnglishSelected ? 'Siang' : 'सियांग'),
          ),
          DropdownMenuItem(
            value: 'Tawang',
            child: Text(_isEnglishSelected ? 'Tawang' : 'तवांग'),
          ),
          DropdownMenuItem(
            value: 'Tirap',
            child: Text(_isEnglishSelected ? 'Tirap' : 'तिराप'),
          ),
          DropdownMenuItem(
            value: 'Upper Dibang Valley',
            child: Text(_isEnglishSelected
                ? 'Upper Dibang Valley'
                : 'ऊपरी दिबांग घाटी'),
          ),
          DropdownMenuItem(
            value: 'Upper Siang',
            child: Text(_isEnglishSelected ? 'Upper Siang' : 'ऊपरी सियांग'),
          ),
          DropdownMenuItem(
            value: 'Upper Subansiri',
            child:
                Text(_isEnglishSelected ? 'Upper Subansiri' : 'ऊपरी सुभानसिरी'),
          ),
          DropdownMenuItem(
            value: 'West Kameng',
            child: Text(_isEnglishSelected ? 'West Kameng' : 'वेस्ट कामेंग'),
          ),
          DropdownMenuItem(
            value: 'West Siang',
            child: Text(_isEnglishSelected ? 'West Siang' : 'पश्चिम सियांग'),
          ),
        ];
      case 'Assam':
        return [
          DropdownMenuItem(
            value: 'Baksa',
            child: Text(_isEnglishSelected ? 'Baksa' : 'बक्सा'),
          ),
          DropdownMenuItem(
            value: 'Barpeta',
            child: Text(_isEnglishSelected ? 'Barpeta' : 'बारपेटा'),
          ),
          DropdownMenuItem(
            value: 'Bishwanath',
            child: Text(_isEnglishSelected ? 'Bishwanath' : 'बिश्वनाथ'),
          ),
          DropdownMenuItem(
            value: 'Bongaigaon',
            child: Text(_isEnglishSelected ? 'Bongaigaon' : 'बोंगाईगांव'),
          ),
          DropdownMenuItem(
            value: 'Cachar',
            child: Text(_isEnglishSelected ? 'Cachar' : 'कछार'),
          ),
          DropdownMenuItem(
            value: 'Charaideo',
            child: Text(_isEnglishSelected ? 'Charaideo' : 'चारेदो'),
          ),
          DropdownMenuItem(
            value: 'Chirang',
            child: Text(_isEnglishSelected ? 'Chirang' : 'चिरंग'),
          ),
          DropdownMenuItem(
            value: 'Darrang',
            child: Text(_isEnglishSelected ? 'Darrang' : 'दारांग'),
          ),
          DropdownMenuItem(
            value: 'Dhemaji',
            child: Text(_isEnglishSelected ? 'Dhemaji' : 'Dhemaji'),
          ),
          DropdownMenuItem(
            value: 'Dhubri',
            child: Text(_isEnglishSelected ? 'Dhubri' : 'ढुलू'),
          ),
          DropdownMenuItem(
            value: 'Dibrugarh',
            child: Text(_isEnglishSelected ? 'Dibrugarh' : 'डिब्रूगढ़'),
          ),
          DropdownMenuItem(
            value: 'Dima Hasao',
            child: Text(_isEnglishSelected ? 'Dima Hasao' : 'दीमा हसाओ'),
          ),
          DropdownMenuItem(
            value: 'Goalpara',
            child: Text(_isEnglishSelected ? 'Goalpara' : 'ग्वालपाड़ा'),
          ),
          DropdownMenuItem(
            value: 'Golaghat',
            child: Text(_isEnglishSelected ? 'Golaghat' : 'गोलाघाट'),
          ),
          DropdownMenuItem(
            value: 'Hailakandi',
            child: Text(_isEnglishSelected ? 'Hailakandi' : 'हैलकंडी'),
          ),
          DropdownMenuItem(
            value: 'Hojai',
            child: Text(_isEnglishSelected ? 'Hojai' : 'होजाई'),
          ),
          DropdownMenuItem(
            value: 'Jorhat',
            child: Text(_isEnglishSelected ? 'Jorhat' : 'जोरहाट'),
          ),
          DropdownMenuItem(
            value: 'Kamrup',
            child: Text(_isEnglishSelected ? 'Kamrup' : 'कामरूप'),
          ),
          DropdownMenuItem(
            value: 'Kamrup Metropolitan',
            child: Text(_isEnglishSelected
                ? 'Kamrup Metropolitan'
                : 'कामरूप मेट्रोपॉलिटन'),
          ),
          DropdownMenuItem(
            value: 'Karbi Anglong',
            child:
                Text(_isEnglishSelected ? 'Karbi Anglong' : 'कार्बी आंगलोंग'),
          ),
          DropdownMenuItem(
            value: 'Karimganj',
            child: Text(_isEnglishSelected ? 'Karimganj' : 'करीमगंज'),
          ),
          DropdownMenuItem(
            value: 'Kokrajhar',
            child: Text(_isEnglishSelected ? 'Kokrajhar' : 'कोकराझार'),
          ),
          DropdownMenuItem(
            value: 'Lakhimpur',
            child: Text(_isEnglishSelected ? 'Lakhimpur' : 'लखीमपुर'),
          ),
          DropdownMenuItem(
            value: 'Majuli',
            child: Text(_isEnglishSelected ? 'Majuli' : 'माजुली'),
          ),
          DropdownMenuItem(
            value: 'Morigaon',
            child: Text(_isEnglishSelected ? 'Morigaon' : 'मोरीगांव'),
          ),
          DropdownMenuItem(
            value: 'Nagaon',
            child: Text(_isEnglishSelected ? 'Nagaon' : 'नौगांव'),
          ),
          DropdownMenuItem(
            value: 'Nalbari',
            child: Text(_isEnglishSelected ? 'Nalbari' : 'नलबाड़ी'),
          ),
          DropdownMenuItem(
            value: 'Sivasagar',
            child: Text(_isEnglishSelected ? 'Sivasagar' : 'शिवसागर'),
          ),
          DropdownMenuItem(
            value: 'South Salmara',
            child:
                Text(_isEnglishSelected ? 'South Salmara' : 'दक्षिण सालमारा'),
          ),
          DropdownMenuItem(
            value: 'Sonitpur',
            child: Text(_isEnglishSelected ? 'Sonitpur' : 'सोनितपुर'),
          ),
          DropdownMenuItem(
            value: 'Tinsukia',
            child: Text(_isEnglishSelected ? 'Tinsukia' : 'तिनसुकिया'),
          ),
          DropdownMenuItem(
            value: 'Udalguri',
            child: Text(_isEnglishSelected ? 'Udalguri' : 'उदालुगुड़ी'),
          ),
          DropdownMenuItem(
            value: 'West Karbi Anglong',
            child: Text(_isEnglishSelected
                ? 'West Karbi Anglong'
                : 'वेस्ट कार्बी आंगलोंग'),
          ),
        ];
      case 'Bihar':
        return [
          DropdownMenuItem(
            value: 'Araria',
            child: Text(_isEnglishSelected ? 'Araria' : 'अररिया'),
          ),
          DropdownMenuItem(
            value: 'Arwal',
            child: Text(_isEnglishSelected ? 'Arwal' : 'अरवल'),
          ),
          DropdownMenuItem(
            value: 'Aurangabad',
            child: Text(_isEnglishSelected ? 'Aurangabad' : 'औरंगाबाद'),
          ),
          DropdownMenuItem(
            value: 'Banka',
            child: Text(_isEnglishSelected ? 'Banka' : 'बांका।'),
          ),
          DropdownMenuItem(
            value: 'Begusarai',
            child: Text(_isEnglishSelected ? 'Begusarai' : 'बेगूसराय।'),
          ),
          DropdownMenuItem(
            value: 'Bhagalpur',
            child: Text(_isEnglishSelected ? 'Bhagalpur' : 'भागलपुर'),
          ),
          DropdownMenuItem(
            value: 'Bhojpur',
            child: Text(_isEnglishSelected ? 'Bhojpur' : 'भोजपुर'),
          ),
          DropdownMenuItem(
            value: 'Buxar',
            child: Text(_isEnglishSelected ? 'Buxar' : 'बक्सर'),
          ),
          DropdownMenuItem(
            value: 'Darbhanga',
            child: Text(_isEnglishSelected ? 'Darbhanga' : 'दरभंगा'),
          ),
          DropdownMenuItem(
            value: 'East Champaran',
            child:
                Text(_isEnglishSelected ? 'East Champaran' : 'पूर्वी चंपारण'),
          ),
          DropdownMenuItem(
            value: 'Gaya',
            child: Text(_isEnglishSelected ? 'Gaya' : 'गया'),
          ),
          DropdownMenuItem(
            value: 'Gopalganj',
            child: Text(_isEnglishSelected ? 'Gopalganj' : 'गोपालगंज'),
          ),
          DropdownMenuItem(
            value: 'Jamui',
            child: Text(_isEnglishSelected ? 'Jamui' : 'जमुई'),
          ),
          DropdownMenuItem(
            value: 'Jehanabad',
            child: Text(_isEnglishSelected ? 'Jehanabad' : 'जहानाबाद'),
          ),
          DropdownMenuItem(
            value: 'Kaimur',
            child: Text(_isEnglishSelected ? 'Kaimur' : 'कैमूर'),
          ),
          DropdownMenuItem(
            value: 'Katihar',
            child: Text(_isEnglishSelected ? 'Katihar' : 'कटिहार'),
          ),
          DropdownMenuItem(
            value: 'Khagaria',
            child: Text(_isEnglishSelected ? 'Khagaria' : 'खगड़िया'),
          ),
          DropdownMenuItem(
            value: 'Kishanganj',
            child: Text(_isEnglishSelected ? 'Kishanganj' : 'किशनगंज'),
          ),
          DropdownMenuItem(
            value: 'Lakhisarai',
            child: Text(_isEnglishSelected ? 'Lakhisarai' : 'लखीसराय।'),
          ),
          DropdownMenuItem(
            value: 'Madhepura',
            child: Text(_isEnglishSelected ? 'Madhepura' : 'मधेपुरा'),
          ),
          DropdownMenuItem(
            value: 'Madhubani',
            child: Text(_isEnglishSelected ? 'Madhubani' : 'मधुबनी'),
          ),
          DropdownMenuItem(
            value: 'Munger',
            child: Text(_isEnglishSelected ? 'Munger' : 'मुंगेर'),
          ),
          DropdownMenuItem(
            value: 'Muzaffarpur',
            child: Text(_isEnglishSelected ? 'Muzaffarpur' : 'मुजफ्फरपुर'),
          ),
          DropdownMenuItem(
            value: 'Nalanda',
            child: Text(_isEnglishSelected ? 'Nalanda' : 'नालंदा'),
          ),
          DropdownMenuItem(
            value: 'Nawada',
            child: Text(_isEnglishSelected ? 'Nawada' : 'नवादा'),
          ),
          DropdownMenuItem(
            value: 'Patna',
            child: Text(_isEnglishSelected ? 'Patna' : 'पटना'),
          ),
          DropdownMenuItem(
            value: 'Purnia',
            child: Text(_isEnglishSelected ? 'Purnia' : 'पूर्णिया'),
          ),
          DropdownMenuItem(
            value: 'Rohtas',
            child: Text(_isEnglishSelected ? 'Rohtas' : 'रोहतास'),
          ),
          DropdownMenuItem(
            value: 'Saharsa',
            child: Text(_isEnglishSelected ? 'Saharsa' : 'सहरसा'),
          ),
          DropdownMenuItem(
            value: 'Samastipur',
            child: Text(_isEnglishSelected ? 'Samastipur' : 'समस्तीपुर'),
          ),
          DropdownMenuItem(
            value: 'Saran',
            child: Text(_isEnglishSelected ? 'Saran' : 'सरन'),
          ),
          DropdownMenuItem(
            value: 'Sheikhpura',
            child: Text(_isEnglishSelected ? 'Sheikhpura' : 'शेखपुरा'),
          ),
          DropdownMenuItem(
            value: 'Sheohar',
            child: Text(_isEnglishSelected ? 'Sheohar' : 'शेओहर'),
          ),
          DropdownMenuItem(
            value: 'Sitamarhi',
            child: Text(_isEnglishSelected ? 'Sitamarhi' : 'सीतामढ़ी'),
          ),
          DropdownMenuItem(
            value: 'Siwan',
            child: Text(_isEnglishSelected ? 'Siwan' : 'सिवान'),
          ),
          DropdownMenuItem(
            value: 'Supaul',
            child: Text(_isEnglishSelected ? 'Supaul' : 'सुपौल'),
          ),
          DropdownMenuItem(
            value: 'Vaishali',
            child: Text(_isEnglishSelected ? 'Vaishali' : 'वैशाली'),
          ),
          DropdownMenuItem(
            value: 'West Champaran',
            child:
                Text(_isEnglishSelected ? 'West Champaran' : 'पश्चिमी चंपारण'),
          ),
        ];
      case 'Chhattisgarh':
        return [
          DropdownMenuItem(
            value: 'Balod',
            child: Text(_isEnglishSelected ? 'Balod' : 'बालोद'),
          ),
          DropdownMenuItem(
            value: 'Baloda Bazar',
            child: Text(_isEnglishSelected ? 'Baloda Bazar' : 'बलौदा बाजार'),
          ),
          DropdownMenuItem(
            value: 'Balrampur',
            child: Text(_isEnglishSelected ? 'Balrampur' : 'बलरामपुर।'),
          ),
          DropdownMenuItem(
            value: 'Bastar',
            child: Text(_isEnglishSelected ? 'Bastar' : 'बस्तर'),
          ),
          DropdownMenuItem(
            value: 'Bemetara',
            child: Text(_isEnglishSelected ? 'Bemetara' : 'बेमेरातारा'),
          ),
          DropdownMenuItem(
            value: 'Bijapur',
            child: Text(_isEnglishSelected ? 'Bijapur' : 'बीजापुर'),
          ),
          DropdownMenuItem(
            value: 'Bilaspur',
            child: Text(_isEnglishSelected ? 'Bilaspur' : 'बिलासपुर'),
          ),
          DropdownMenuItem(
            value: 'Dantewada',
            child: Text(_isEnglishSelected ? 'Dantewada' : 'दंतेवाड़ा।'),
          ),
          DropdownMenuItem(
            value: 'Dhamtari',
            child: Text(_isEnglishSelected ? 'Dhamtari' : 'धमतरी'),
          ),
          DropdownMenuItem(
            value: 'Durg',
            child: Text(_isEnglishSelected ? 'Durg' : 'दुर्ग'),
          ),
          DropdownMenuItem(
            value: 'Gariaband',
            child: Text(_isEnglishSelected ? 'Gariaband' : 'गरियाबंद'),
          ),
          DropdownMenuItem(
            value: 'Gaurela-Pendra-Marwahi',
            child: Text(_isEnglishSelected
                ? 'Gaurela-Pendra-Marwahi'
                : 'गौरेला-पेंड्रा-मरवाही'),
          ),
          DropdownMenuItem(
            value: 'Janjgir-Champa',
            child:
                Text(_isEnglishSelected ? 'Janjgir-Champa' : 'जांजगीर-चांपा'),
          ),
          DropdownMenuItem(
            value: 'Jashpur',
            child: Text(_isEnglishSelected ? 'Jashpur' : 'जशपुर'),
          ),
          DropdownMenuItem(
            value: 'Kabirdham',
            child: Text(_isEnglishSelected ? 'Kabirdham' : 'कबीरधाम'),
          ),
          DropdownMenuItem(
            value: 'Kanker',
            child: Text(_isEnglishSelected ? 'Kanker' : 'कांकेर'),
          ),
          DropdownMenuItem(
            value: 'Kondagaon',
            child: Text(_isEnglishSelected ? 'Kondagaon' : 'कोंडागांव'),
          ),
          DropdownMenuItem(
            value: 'Korba',
            child: Text(_isEnglishSelected ? 'Korba' : 'कोरबा'),
          ),
          DropdownMenuItem(
            value: 'Koriya',
            child: Text(_isEnglishSelected ? 'Koriya' : 'कोरिया'),
          ),
          DropdownMenuItem(
            value: 'Mahasamund',
            child: Text(_isEnglishSelected ? 'Mahasamund' : 'महासमुंद।'),
          ),
          DropdownMenuItem(
            value: 'Mungeli',
            child: Text(_isEnglishSelected ? 'Mungeli' : 'मुंगेली'),
          ),
          DropdownMenuItem(
            value: 'Narayanpur',
            child: Text(_isEnglishSelected ? 'Narayanpur' : 'नारायणपुर'),
          ),
          DropdownMenuItem(
            value: 'Raigarh',
            child: Text(_isEnglishSelected ? 'Raigarh' : 'रायगढ़।'),
          ),
          DropdownMenuItem(
            value: 'Raipur',
            child: Text(_isEnglishSelected ? 'Raipur' : 'रायपुर'),
          ),
          DropdownMenuItem(
            value: 'Rajnandgaon',
            child: Text(_isEnglishSelected ? 'Rajnandgaon' : 'राजनांदगांव'),
          ),
          DropdownMenuItem(
            value: 'Sukma',
            child: Text(_isEnglishSelected ? 'Sukma' : 'सुकमा'),
          ),
          DropdownMenuItem(
            value: 'Surajpur',
            child: Text(_isEnglishSelected ? 'Surajpur' : 'सूरजपुर'),
          ),
          DropdownMenuItem(
            value: 'Surguja',
            child: Text(_isEnglishSelected ? 'Surguja' : 'सरगुजा'),
          ),
        ];
      case 'Goa':
        return [
          DropdownMenuItem(
            value: 'North Goa',
            child: Text(_isEnglishSelected ? 'North Goa' : 'उत्तरी गोवा'),
          ),
          DropdownMenuItem(
            value: 'South Goa',
            child: Text(_isEnglishSelected ? 'South Goa' : 'दक्षिण गोवा'),
          ),
        ];
      case 'Gujarat':
        return [
          DropdownMenuItem(
            value: 'Ahmedabad',
            child: Text(_isEnglishSelected ? 'Ahmedabad' : 'अहमदाबाद'),
          ),
          DropdownMenuItem(
            value: 'Amreli',
            child: Text(_isEnglishSelected ? 'Amreli' : 'अमरेली'),
          ),
          DropdownMenuItem(
            value: 'Anand',
            child: Text(_isEnglishSelected ? 'Anand' : 'आनंद'),
          ),
          DropdownMenuItem(
            value: 'Aravalli',
            child: Text(_isEnglishSelected ? 'Aravalli' : 'अरावली'),
          ),
          DropdownMenuItem(
            value: 'Banaskantha',
            child: Text(_isEnglishSelected ? 'Banaskantha' : 'बनासकांठा'),
          ),
          DropdownMenuItem(
            value: 'Bharuch',
            child: Text(_isEnglishSelected ? 'Bharuch' : 'भरूच'),
          ),
          DropdownMenuItem(
            value: 'Bhavnagar',
            child: Text(_isEnglishSelected ? 'Bhavnagar' : 'भावनगर'),
          ),
          DropdownMenuItem(
            value: 'Botad',
            child: Text(_isEnglishSelected ? 'Botad' : 'बोटाद'),
          ),
          DropdownMenuItem(
            value: 'Chhota Udepur',
            child: Text(_isEnglishSelected ? 'Chhota Udepur' : 'छोटा उदेपुर'),
          ),
          DropdownMenuItem(
            value: 'Dahod',
            child: Text(_isEnglishSelected ? 'Dahod' : 'दाहोद'),
          ),
          DropdownMenuItem(
            value: 'Dang',
            child: Text(_isEnglishSelected ? 'Dang' : 'डांग'),
          ),
          DropdownMenuItem(
            value: 'Devbhoomi Dwarka',
            child: Text(
                _isEnglishSelected ? 'Devbhoomi Dwarka' : 'देवभूमि द्वारका'),
          ),
          DropdownMenuItem(
            value: 'Gandhinagar',
            child: Text(_isEnglishSelected ? 'Gandhinagar' : 'गांधीनगर'),
          ),
          DropdownMenuItem(
            value: 'Gir Somnath',
            child: Text(_isEnglishSelected ? 'Gir Somnath' : 'गिर सोमनाथ'),
          ),
          DropdownMenuItem(
            value: 'Jamnagar',
            child: Text(_isEnglishSelected ? 'Jamnagar' : 'जामनगर'),
          ),
          DropdownMenuItem(
            value: 'Junagadh',
            child: Text(_isEnglishSelected ? 'Junagadh' : 'जूनागढ़'),
          ),
          DropdownMenuItem(
            value: 'Kheda',
            child: Text(_isEnglishSelected ? 'Kheda' : 'खेड़ा'),
          ),
          DropdownMenuItem(
            value: 'Kutch',
            child: Text(_isEnglishSelected ? 'Kutch' : 'कच्छ'),
          ),
          DropdownMenuItem(
            value: 'Mahisagar',
            child: Text(_isEnglishSelected ? 'Mahisagar' : 'महिसागर'),
          ),
          DropdownMenuItem(
            value: 'Mehsana',
            child: Text(_isEnglishSelected ? 'Mehsana' : 'मेहसाना'),
          ),
          DropdownMenuItem(
            value: 'Morbi',
            child: Text(_isEnglishSelected ? 'Morbi' : 'मोरबी'),
          ),
          DropdownMenuItem(
            value: 'Narmada',
            child: Text(_isEnglishSelected ? 'Narmada' : 'नर्मदा'),
          ),
          DropdownMenuItem(
            value: 'Navsari',
            child: Text(_isEnglishSelected ? 'Navsari' : 'नवसारी'),
          ),
          DropdownMenuItem(
            value: 'Panchmahal',
            child: Text(_isEnglishSelected ? 'Panchmahal' : 'पंचमहल'),
          ),
          DropdownMenuItem(
            value: 'Patan',
            child: Text(_isEnglishSelected ? 'Patan' : 'पाटन'),
          ),
          DropdownMenuItem(
            value: 'Porbandar',
            child: Text(_isEnglishSelected ? 'Porbandar' : 'पोरबंदर'),
          ),
          DropdownMenuItem(
            value: 'Rajkot',
            child: Text(_isEnglishSelected ? 'Rajkot' : 'राजकोट'),
          ),
          DropdownMenuItem(
            value: 'Sabarkantha',
            child: Text(_isEnglishSelected ? 'Sabarkantha' : 'साबरकांठा'),
          ),
          DropdownMenuItem(
            value: 'Surat',
            child: Text(_isEnglishSelected ? 'Surat' : 'सूरत'),
          ),
          DropdownMenuItem(
            value: 'Surendranagar',
            child: Text(_isEnglishSelected ? 'Surendranagar' : 'सुरेंद्रनगर'),
          ),
          DropdownMenuItem(
            value: 'Tapi',
            child: Text(_isEnglishSelected ? 'Tapi' : 'Tapi'),
          ),
          DropdownMenuItem(
            value: 'Vadodara',
            child: Text(_isEnglishSelected ? 'Vadodara' : 'वडोदरा'),
          ),
          DropdownMenuItem(
            value: 'Valsad',
            child: Text(_isEnglishSelected ? 'Valsad' : 'वलसाड'),
          ),
        ];
      case 'Haryana':
        return [
          DropdownMenuItem(
            value: 'Ambala',
            child: Text(_isEnglishSelected ? 'Ambala' : 'अंबाला'),
          ),
          DropdownMenuItem(
            value: 'Bhiwani',
            child: Text(_isEnglishSelected ? 'Bhiwani' : 'भिवानी'),
          ),
          DropdownMenuItem(
            value: 'Charkhi Dadri',
            child: Text(_isEnglishSelected ? 'Charkhi Dadri' : 'चरखी दादरी'),
          ),
          DropdownMenuItem(
            value: 'Faridabad',
            child: Text(_isEnglishSelected ? 'Faridabad' : 'फरीदाबाद'),
          ),
          DropdownMenuItem(
            value: 'Fatehabad',
            child: Text(_isEnglishSelected ? 'Fatehabad' : 'फतेहाबाद'),
          ),
          DropdownMenuItem(
            value: 'Gurgaon',
            child: Text(_isEnglishSelected ? 'Gurgaon' : 'गुड़गांव'),
          ),
          DropdownMenuItem(
            value: 'Hissar',
            child: Text(_isEnglishSelected ? 'Hissar' : 'हिसार'),
          ),
          DropdownMenuItem(
            value: 'Jhajjar',
            child: Text(_isEnglishSelected ? 'Jhajjar' : 'झज्जर'),
          ),
          DropdownMenuItem(
            value: 'Jind',
            child: Text(_isEnglishSelected ? 'Jind' : 'जीन्द'),
          ),
          DropdownMenuItem(
            value: 'Kaithal',
            child: Text(_isEnglishSelected ? 'Kaithal' : 'कैथल'),
          ),
          DropdownMenuItem(
            value: 'Karnal',
            child: Text(_isEnglishSelected ? 'Karnal' : 'करनाल'),
          ),
          DropdownMenuItem(
            value: 'Kurukshetra',
            child: Text(_isEnglishSelected ? 'Kurukshetra' : 'कुरुक्षेत्र'),
          ),
          DropdownMenuItem(
            value: 'Mahendragarh',
            child: Text(_isEnglishSelected ? 'Mahendragarh' : 'महेंद्रगढ़'),
          ),
          DropdownMenuItem(
            value: 'Nuh',
            child: Text(_isEnglishSelected ? 'Nuh' : 'नूह'),
          ),
          DropdownMenuItem(
            value: 'Palwal',
            child: Text(_isEnglishSelected ? 'Palwal' : 'पलवल।'),
          ),
          DropdownMenuItem(
            value: 'Panchkula',
            child: Text(_isEnglishSelected ? 'Panchkula' : 'पंचकूला।'),
          ),
          DropdownMenuItem(
            value: 'Panipat',
            child: Text(_isEnglishSelected ? 'Panipat' : 'पानीपत'),
          ),
          DropdownMenuItem(
            value: 'Rewari',
            child: Text(_isEnglishSelected ? 'Rewari' : 'रेवाड़ी'),
          ),
          DropdownMenuItem(
            value: 'Rohtak',
            child: Text(_isEnglishSelected ? 'Rohtak' : 'रोहतक'),
          ),
          DropdownMenuItem(
            value: 'Sirsa',
            child: Text(_isEnglishSelected ? 'Sirsa' : 'सिरसा'),
          ),
          DropdownMenuItem(
            value: 'Sonipat',
            child: Text(_isEnglishSelected ? 'Sonipat' : 'सोनीपत'),
          ),
          DropdownMenuItem(
            value: 'Yamuna Nagar',
            child: Text(_isEnglishSelected ? 'Yamuna Nagar' : 'यमुना नगर'),
          ),
        ];
      case 'Himachal Pradesh':
        return [
          DropdownMenuItem(
            value: 'Bilaspur',
            child: Text(_isEnglishSelected ? 'Bilaspur' : 'बिलासपुर'),
          ),
          DropdownMenuItem(
            value: 'Chamba',
            child: Text(_isEnglishSelected ? 'Chamba' : 'चंबा।'),
          ),
          DropdownMenuItem(
            value: 'Hamirpur',
            child: Text(_isEnglishSelected ? 'Hamirpur' : 'हमीरपुर'),
          ),
          DropdownMenuItem(
            value: 'Kangra',
            child: Text(_isEnglishSelected ? 'Kangra' : 'कांगड़ा'),
          ),
          DropdownMenuItem(
            value: 'Kinnaur',
            child: Text(_isEnglishSelected ? 'Kinnaur' : 'किन्नौर'),
          ),
          DropdownMenuItem(
            value: 'Kullu',
            child: Text(_isEnglishSelected ? 'Kullu' : 'कुल्लू'),
          ),
          DropdownMenuItem(
            value: 'Lahaul and Spiti',
            child: Text(
                _isEnglishSelected ? 'Lahaul and Spiti' : 'लाहौल और स्पीति'),
          ),
          DropdownMenuItem(
            value: 'Mandi',
            child: Text(_isEnglishSelected ? 'Mandi' : 'मंडी'),
          ),
          DropdownMenuItem(
            value: 'Shimla',
            child: Text(_isEnglishSelected ? 'Shimla' : 'शिमला'),
          ),
          DropdownMenuItem(
            value: 'Sirmaur',
            child: Text(_isEnglishSelected ? 'Sirmaur' : 'सिरमौर'),
          ),
          DropdownMenuItem(
            value: 'Solan',
            child: Text(_isEnglishSelected ? 'Solan' : 'सोलन'),
          ),
          DropdownMenuItem(
            value: 'Una',
            child: Text(_isEnglishSelected ? 'Una' : 'Una'),
          ),
        ];
      case 'Jharkhand':
        return [
          DropdownMenuItem(
            value: 'Bokaro',
            child: Text(_isEnglishSelected ? 'Bokaro' : 'बोकारो'),
          ),
          DropdownMenuItem(
            value: 'Chatra',
            child: Text(_isEnglishSelected ? 'Chatra' : 'चतरा'),
          ),
          DropdownMenuItem(
            value: 'Deoghar',
            child: Text(_isEnglishSelected ? 'Deoghar' : 'देवघर'),
          ),
          DropdownMenuItem(
            value: 'Dhanbad',
            child: Text(_isEnglishSelected ? 'Dhanbad' : 'धनबाद'),
          ),
          DropdownMenuItem(
            value: 'Dumka',
            child: Text(_isEnglishSelected ? 'Dumka' : 'दुमका'),
          ),
          DropdownMenuItem(
            value: 'East Singhbhum',
            child:
                Text(_isEnglishSelected ? 'East Singhbhum' : 'पूर्वी सिंहभूम'),
          ),
          DropdownMenuItem(
            value: 'Garhwa',
            child: Text(_isEnglishSelected ? 'Garhwa' : 'गढ़वा।'),
          ),
          DropdownMenuItem(
            value: 'Giridih',
            child: Text(_isEnglishSelected ? 'Giridih' : 'गिरिडीह।'),
          ),
          DropdownMenuItem(
            value: 'Godda',
            child: Text(_isEnglishSelected ? 'Godda' : 'गोड्डा'),
          ),
          DropdownMenuItem(
            value: 'Gumla',
            child: Text(_isEnglishSelected ? 'Gumla' : 'गुमला।'),
          ),
          DropdownMenuItem(
            value: 'Hazaribag',
            child: Text(_isEnglishSelected ? 'Hazaribag' : 'हजारीबाग।'),
          ),
          DropdownMenuItem(
            value: 'Jamtara',
            child: Text(_isEnglishSelected ? 'Jamtara' : 'जामताड़ा'),
          ),
          DropdownMenuItem(
            value: 'Khunti',
            child: Text(_isEnglishSelected ? 'Khunti' : 'खूंटी'),
          ),
          DropdownMenuItem(
            value: 'Koderma',
            child: Text(_isEnglishSelected ? 'Koderma' : 'कोडरमा'),
          ),
          DropdownMenuItem(
            value: 'Latehar',
            child: Text(_isEnglishSelected ? 'Latehar' : 'लातेहार'),
          ),
          DropdownMenuItem(
            value: 'Lohardaga',
            child: Text(_isEnglishSelected ? 'Lohardaga' : 'लोहरदगा'),
          ),
          DropdownMenuItem(
            value: 'Pakur',
            child: Text(_isEnglishSelected ? 'Pakur' : 'पाकुड़'),
          ),
          DropdownMenuItem(
            value: 'Palamu',
            child: Text(_isEnglishSelected ? 'Palamu' : 'पलामू'),
          ),
          DropdownMenuItem(
            value: 'Ramgarh',
            child: Text(_isEnglishSelected ? 'Ramgarh' : 'रामगढ़'),
          ),
          DropdownMenuItem(
            value: 'Ranchi',
            child: Text(_isEnglishSelected ? 'Ranchi' : 'रांची'),
          ),
          DropdownMenuItem(
            value: 'Sahibganj',
            child: Text(_isEnglishSelected ? 'Sahibganj' : 'साहिबगंज'),
          ),
          DropdownMenuItem(
            value: 'Seraikela Kharsawan',
            child: Text(_isEnglishSelected
                ? 'Seraikela Kharsawan'
                : 'सेरीकेला खरसावां'),
          ),
          DropdownMenuItem(
            value: 'Simdega',
            child: Text(_isEnglishSelected ? 'Simdega' : 'सिमडेगा'),
          ),
          DropdownMenuItem(
            value: 'West Singhbhum',
            child:
                Text(_isEnglishSelected ? 'West Singhbhum' : 'पश्चिमी सिंहभूम'),
          ),
        ];
      case 'Karnataka':
        return [
          DropdownMenuItem(
            value: 'Bagalkot',
            child: Text(_isEnglishSelected ? 'Bagalkot' : 'बागलकोट'),
          ),
          DropdownMenuItem(
            value: 'Ballari',
            child: Text(_isEnglishSelected ? 'Ballari' : 'बल्लारी'),
          ),
          DropdownMenuItem(
            value: 'Belgaum',
            child: Text(_isEnglishSelected ? 'Belgaum' : 'बेलगाम'),
          ),
          DropdownMenuItem(
            value: 'Bangalore Rural',
            child: Text(
                _isEnglishSelected ? 'Bangalore Rural' : 'बैंगलोर ग्रामीण'),
          ),
          DropdownMenuItem(
            value: 'Bangalore Urban',
            child:
                Text(_isEnglishSelected ? 'Bangalore Urban' : 'बैंगलोर शहरी'),
          ),
          DropdownMenuItem(
            value: 'Bidar',
            child: Text(_isEnglishSelected ? 'Bidar' : 'बीदर'),
          ),
          DropdownMenuItem(
            value: 'Chamarajnagar',
            child: Text(_isEnglishSelected ? 'Chamarajnagar' : 'चामराजनगर'),
          ),
          DropdownMenuItem(
            value: 'Chikkaballapur',
            child:
                Text(_isEnglishSelected ? 'Chikkaballapur' : 'चिक्काबल्लापुर'),
          ),
          DropdownMenuItem(
            value: 'Chikkamagaluru',
            child: Text(_isEnglishSelected ? 'Chikkamagaluru' : 'चिकाकामालुरु'),
          ),
          DropdownMenuItem(
            value: 'Chitradurga',
            child: Text(_isEnglishSelected ? 'Chitradurga' : 'चित्रदुर्ग'),
          ),
          DropdownMenuItem(
            value: 'Dakshina Kannada',
            child:
                Text(_isEnglishSelected ? 'Dakshina Kannada' : 'दक्षिण कन्नड़'),
          ),
          DropdownMenuItem(
            value: 'Davanagere',
            child: Text(_isEnglishSelected ? 'Davanagere' : 'दावनगेरे'),
          ),
          DropdownMenuItem(
            value: 'Dharwad',
            child: Text(_isEnglishSelected ? 'Dharwad' : 'धारवाड़'),
          ),
          DropdownMenuItem(
            value: 'Gadag',
            child: Text(_isEnglishSelected ? 'Gadag' : 'गाडग'),
          ),
          DropdownMenuItem(
            value: 'Gulbarga',
            child: Text(_isEnglishSelected ? 'Gulbarga' : 'गुलबर्गा'),
          ),
          DropdownMenuItem(
            value: 'Hassan',
            child: Text(_isEnglishSelected ? 'Hassan' : 'हसन'),
          ),
          DropdownMenuItem(
            value: 'Haveri',
            child: Text(_isEnglishSelected ? 'Haveri' : 'हैवेरी'),
          ),
          DropdownMenuItem(
            value: 'Kodagu',
            child: Text(_isEnglishSelected ? 'Kodagu' : 'कोडागू'),
          ),
          DropdownMenuItem(
            value: 'Kolar',
            child: Text(_isEnglishSelected ? 'Kolar' : 'कोलार'),
          ),
          DropdownMenuItem(
            value: 'Koppal',
            child: Text(_isEnglishSelected ? 'Koppal' : 'कोप्पल'),
          ),
          DropdownMenuItem(
            value: 'Mandya',
            child: Text(_isEnglishSelected ? 'Mandya' : 'मांड्या'),
          ),
          DropdownMenuItem(
            value: 'Mysuru',
            child: Text(_isEnglishSelected ? 'Mysuru' : 'मैसूर'),
          ),
          DropdownMenuItem(
            value: 'Raichur',
            child: Text(_isEnglishSelected ? 'Raichur' : 'रायचूर'),
          ),
          DropdownMenuItem(
            value: 'Ramanagara',
            child: Text(_isEnglishSelected ? 'Ramanagara' : 'रामनगरा'),
          ),
          DropdownMenuItem(
            value: 'Shimoga',
            child: Text(_isEnglishSelected ? 'Shimoga' : 'शिमोगा'),
          ),
          DropdownMenuItem(
            value: 'Tumakuru',
            child: Text(_isEnglishSelected ? 'Tumakuru' : 'तुमाकुरू'),
          ),
          DropdownMenuItem(
            value: 'Udupi',
            child: Text(_isEnglishSelected ? 'Udupi' : 'उडुपी'),
          ),
          DropdownMenuItem(
            value: 'Uttara Kannada',
            child:
                Text(_isEnglishSelected ? 'Uttara Kannada' : 'उत्तरा कन्नड़'),
          ),
          DropdownMenuItem(
            value: 'Vijayapura',
            child: Text(_isEnglishSelected ? 'Vijayapura' : 'विजयपुरा'),
          ),
          DropdownMenuItem(
            value: 'Yadgir',
            child: Text(_isEnglishSelected ? 'Yadgir' : 'यादगीर'),
          ),
        ];
      case 'Kerala':
        return [
          DropdownMenuItem(
            value: 'Alappuzha',
            child: Text(_isEnglishSelected ? 'Alappuzha' : 'अलाप्पुझा'),
          ),
          DropdownMenuItem(
            value: 'Ernakulam',
            child: Text(_isEnglishSelected ? 'Ernakulam' : 'एर्नाकुलम'),
          ),
          DropdownMenuItem(
            value: 'Idukki',
            child: Text(_isEnglishSelected ? 'Idukki' : 'इडुक्की'),
          ),
          DropdownMenuItem(
            value: 'Kannur',
            child: Text(_isEnglishSelected ? 'Kannur' : 'कन्नूर'),
          ),
          DropdownMenuItem(
            value: 'Kasaragod',
            child: Text(_isEnglishSelected ? 'Kasaragod' : 'कासरगोड'),
          ),
          DropdownMenuItem(
            value: 'Kollam',
            child: Text(_isEnglishSelected ? 'Kollam' : 'कोल्लम'),
          ),
          DropdownMenuItem(
            value: 'Kottayam',
            child: Text(_isEnglishSelected ? 'Kottayam' : 'कोट्टायम'),
          ),
          DropdownMenuItem(
            value: 'Kozhikode',
            child: Text(_isEnglishSelected ? 'Kozhikode' : 'कोझीकोड'),
          ),
          DropdownMenuItem(
            value: 'Malappuram',
            child: Text(_isEnglishSelected ? 'Malappuram' : 'मलप्पुरम'),
          ),
          DropdownMenuItem(
            value: 'Palakkad',
            child: Text(_isEnglishSelected ? 'Palakkad' : 'पलक्कड़'),
          ),
          DropdownMenuItem(
            value: 'Pathanamthitta',
            child: Text(_isEnglishSelected ? 'Pathanamthitta' : 'पठानमथिट्टा'),
          ),
          DropdownMenuItem(
            value: 'Thrissur',
            child: Text(_isEnglishSelected ? 'Thrissur' : 'त्रिशूर'),
          ),
          DropdownMenuItem(
            value: 'Thiruvananthapuram',
            child: Text(
                _isEnglishSelected ? 'Thiruvananthapuram' : 'तिरुअनंतपुरम'),
          ),
          DropdownMenuItem(
            value: 'Wayanad',
            child: Text(_isEnglishSelected ? 'Wayanad' : 'वायनाड'),
          ),
        ];
      case 'Madhya Pradesh':
        return [
          DropdownMenuItem(
            value: 'Agar Malwa',
            child: Text(_isEnglishSelected ? 'Agar Malwa' : 'आगर मालवा'),
          ),
          DropdownMenuItem(
            value: 'Alirajpur',
            child: Text(_isEnglishSelected ? 'Alirajpur' : 'अलीराजपुर'),
          ),
          DropdownMenuItem(
            value: 'Anuppur',
            child: Text(_isEnglishSelected ? 'Anuppur' : 'अनूपपुर'),
          ),
          DropdownMenuItem(
            value: 'Ashok Nagar',
            child: Text(_isEnglishSelected ? 'Ashok Nagar' : 'अशोक नगर'),
          ),
          DropdownMenuItem(
            value: 'Balaghat',
            child: Text(_isEnglishSelected ? 'Balaghat' : 'बालाघाट'),
          ),
          DropdownMenuItem(
            value: 'Barwani',
            child: Text(_isEnglishSelected ? 'Barwani' : 'बड़वानी'),
          ),
          DropdownMenuItem(
            value: 'Betul',
            child: Text(_isEnglishSelected ? 'Betul' : 'बैतूल'),
          ),
          DropdownMenuItem(
            value: 'Bhind',
            child: Text(_isEnglishSelected ? 'Bhind' : 'भिंड।'),
          ),
          DropdownMenuItem(
            value: 'Bhopal',
            child: Text(_isEnglishSelected ? 'Bhopal' : 'भोपाल'),
          ),
          DropdownMenuItem(
            value: 'Burhanpur',
            child: Text(_isEnglishSelected ? 'Burhanpur' : 'बुरहानपुर'),
          ),
          DropdownMenuItem(
            value: 'Chachaura-Binaganj',
            child: Text(
                _isEnglishSelected ? 'Chachaura-Binaganj' : 'चचौरा-बीनागंज'),
          ),
          DropdownMenuItem(
            value: 'Chhatarpur',
            child: Text(_isEnglishSelected ? 'Chhatarpur' : 'छतरपुर'),
          ),
          DropdownMenuItem(
            value: 'Chhindwara',
            child: Text(_isEnglishSelected ? 'Chhindwara' : 'छिंदवाड़ा'),
          ),
          DropdownMenuItem(
            value: 'Damoh',
            child: Text(_isEnglishSelected ? 'Damoh' : 'Damoh'),
          ),
          DropdownMenuItem(
            value: 'Datia',
            child: Text(_isEnglishSelected ? 'Datia' : 'दतिया'),
          ),
          DropdownMenuItem(
            value: 'Dewas',
            child: Text(_isEnglishSelected ? 'Dewas' : 'देवास'),
          ),
          DropdownMenuItem(
            value: 'Dhar',
            child: Text(_isEnglishSelected ? 'Dhar' : 'धर'),
          ),
          DropdownMenuItem(
            value: 'Dindori',
            child: Text(_isEnglishSelected ? 'Dindori' : 'डिंडोरी'),
          ),
          DropdownMenuItem(
            value: 'Guna',
            child: Text(_isEnglishSelected ? 'Guna' : 'गुना'),
          ),
          DropdownMenuItem(
            value: 'Gwalior',
            child: Text(_isEnglishSelected ? 'Gwalior' : 'ग्वालियर'),
          ),
          DropdownMenuItem(
            value: 'Harda',
            child: Text(_isEnglishSelected ? 'Harda' : 'हरदा'),
          ),
          DropdownMenuItem(
            value: 'Hoshangabad',
            child: Text(_isEnglishSelected ? 'Hoshangabad' : 'होशंगाबाद'),
          ),
          DropdownMenuItem(
            value: 'Indore',
            child: Text(_isEnglishSelected ? 'Indore' : 'इंदौर'),
          ),
          DropdownMenuItem(
            value: 'Jabalpur',
            child: Text(_isEnglishSelected ? 'Jabalpur' : 'जबलपुर'),
          ),
          DropdownMenuItem(
            value: 'Jhabua',
            child: Text(_isEnglishSelected ? 'Jhabua' : 'झबुआ'),
          ),
          DropdownMenuItem(
            value: 'Katni',
            child: Text(_isEnglishSelected ? 'Katni' : 'कटनी'),
          ),
          DropdownMenuItem(
            value: 'Khandwa   (East Nimar)',
            child: Text(_isEnglishSelected
                ? 'Khandwa   (East Nimar)'
                : 'खंडवा (पूर्व निमाड़)'),
          ),
          DropdownMenuItem(
            value: 'Khargone   (West Nimar)',
            child: Text(_isEnglishSelected
                ? 'Khargone   (West Nimar)'
                : 'खरगोन (पश्चिम निमाड़)'),
          ),
          DropdownMenuItem(
            value: 'Maihar',
            child: Text(_isEnglishSelected ? 'Maihar' : 'मैहर'),
          ),
          DropdownMenuItem(
            value: 'Mandla',
            child: Text(_isEnglishSelected ? 'Mandla' : 'मंडला'),
          ),
          DropdownMenuItem(
            value: 'Mandsaur',
            child: Text(_isEnglishSelected ? 'Mandsaur' : 'मंदसौर'),
          ),
          DropdownMenuItem(
            value: 'Morena',
            child: Text(_isEnglishSelected ? 'Morena' : 'मुरैना'),
          ),
          DropdownMenuItem(
            value: 'Narsinghpur',
            child: Text(_isEnglishSelected ? 'Narsinghpur' : 'नरसिंहपुर'),
          ),
          DropdownMenuItem(
            value: 'Nagda',
            child: Text(_isEnglishSelected ? 'Nagda' : 'नागदा'),
          ),
          DropdownMenuItem(
            value: 'Neemuch',
            child: Text(_isEnglishSelected ? 'Neemuch' : 'नीमच'),
          ),
          DropdownMenuItem(
            value: 'Niwari',
            child: Text(_isEnglishSelected ? 'Niwari' : 'निवाड़ी'),
          ),
          DropdownMenuItem(
            value: 'Panna',
            child: Text(_isEnglishSelected ? 'Panna' : 'पन्ना'),
          ),
          DropdownMenuItem(
            value: 'Raisen',
            child: Text(_isEnglishSelected ? 'Raisen' : 'रायसेन'),
          ),
          DropdownMenuItem(
            value: 'Rajgarh',
            child: Text(_isEnglishSelected ? 'Rajgarh' : 'राजगढ़।'),
          ),
          DropdownMenuItem(
            value: 'Ratlam',
            child: Text(_isEnglishSelected ? 'Ratlam' : 'रतलाम'),
          ),
          DropdownMenuItem(
            value: 'Rewa',
            child: Text(_isEnglishSelected ? 'Rewa' : 'रीवा'),
          ),
          DropdownMenuItem(
            value: 'Sagar',
            child: Text(_isEnglishSelected ? 'Sagar' : 'सागर'),
          ),
          DropdownMenuItem(
            value: 'Satna',
            child: Text(_isEnglishSelected ? 'Satna' : 'सतना'),
          ),
          DropdownMenuItem(
            value: 'Sehore',
            child: Text(_isEnglishSelected ? 'Sehore' : 'सीहोर'),
          ),
          DropdownMenuItem(
            value: 'Seoni',
            child: Text(_isEnglishSelected ? 'Seoni' : 'सिवनी'),
          ),
          DropdownMenuItem(
            value: 'Shahdol',
            child: Text(_isEnglishSelected ? 'Shahdol' : 'शहडोल'),
          ),
          DropdownMenuItem(
            value: 'Shajapur',
            child: Text(_isEnglishSelected ? 'Shajapur' : 'शाजापुर'),
          ),
          DropdownMenuItem(
            value: 'Sheopur',
            child: Text(_isEnglishSelected ? 'Sheopur' : 'शेओपुर'),
          ),
          DropdownMenuItem(
            value: 'Shivpuri',
            child: Text(_isEnglishSelected ? 'Shivpuri' : 'शिवपुरी।'),
          ),
          DropdownMenuItem(
            value: 'Sidhi',
            child: Text(_isEnglishSelected ? 'Sidhi' : 'सीधी'),
          ),
          DropdownMenuItem(
            value: 'Singrauli',
            child: Text(_isEnglishSelected ? 'Singrauli' : 'सिंगरौली'),
          ),
          DropdownMenuItem(
            value: 'Tikamgarh',
            child: Text(_isEnglishSelected ? 'Tikamgarh' : 'टीकमगढ़'),
          ),
          DropdownMenuItem(
            value: 'Ujjain',
            child: Text(_isEnglishSelected ? 'Ujjain' : 'उज्जैन'),
          ),
          DropdownMenuItem(
            value: 'Umaria',
            child: Text(_isEnglishSelected ? 'Umaria' : 'उमरिया।'),
          ),
          DropdownMenuItem(
            value: 'Vidisha',
            child: Text(_isEnglishSelected ? 'Vidisha' : 'विदिशा'),
          ),
        ];
      case 'Maharashtra':
        return [
          DropdownMenuItem(
            value: 'Ahmednagar',
            child: Text(_isEnglishSelected ? 'Ahmednagar' : 'अहमदनगर'),
          ),
          DropdownMenuItem(
            value: 'Akola',
            child: Text(_isEnglishSelected ? 'Akola' : 'अकोला'),
          ),
          DropdownMenuItem(
            value: 'Amravati',
            child: Text(_isEnglishSelected ? 'Amravati' : 'अमरावती'),
          ),
          DropdownMenuItem(
            value: 'Aurangabad',
            child: Text(_isEnglishSelected ? 'Aurangabad' : 'औरंगाबाद'),
          ),
          DropdownMenuItem(
            value: 'Beed',
            child: Text(_isEnglishSelected ? 'Beed' : 'बीड'),
          ),
          DropdownMenuItem(
            value: 'Bhandara',
            child: Text(_isEnglishSelected ? 'Bhandara' : 'भंडारा'),
          ),
          DropdownMenuItem(
            value: 'Buldhana',
            child: Text(_isEnglishSelected ? 'Buldhana' : 'बुलढाणा'),
          ),
          DropdownMenuItem(
            value: 'Chandrapur',
            child: Text(_isEnglishSelected ? 'Chandrapur' : 'चंद्रपूर'),
          ),
          DropdownMenuItem(
            value: 'Dhule',
            child: Text(_isEnglishSelected ? 'Dhule' : 'धुळे'),
          ),
          DropdownMenuItem(
            value: 'Gadchiroli',
            child: Text(_isEnglishSelected ? 'Gadchiroli' : 'गडचिरोली'),
          ),
          DropdownMenuItem(
            value: 'Gondia',
            child: Text(_isEnglishSelected ? 'Gondia' : 'गोंदिया'),
          ),
          DropdownMenuItem(
            value: 'Hingoli',
            child: Text(_isEnglishSelected ? 'Hingoli' : 'हिंगोली'),
          ),
          DropdownMenuItem(
            value: 'Jalgaon',
            child: Text(_isEnglishSelected ? 'Jalgaon' : 'जळगाव'),
          ),
          DropdownMenuItem(
            value: 'Jalna',
            child: Text(_isEnglishSelected ? 'Jalna' : 'जालना'),
          ),
          DropdownMenuItem(
            value: 'Kolhapur',
            child: Text(_isEnglishSelected ? 'Kolhapur' : 'कोल्हापूर'),
          ),
          DropdownMenuItem(
            value: 'Latur',
            child: Text(_isEnglishSelected ? 'Latur' : 'लातूर'),
          ),
          DropdownMenuItem(
            value: 'Mumbai City',
            child: Text(_isEnglishSelected ? 'Mumbai City' : 'मुंबई शहर'),
          ),
          DropdownMenuItem(
            value: 'Mumbai suburban',
            child:
                Text(_isEnglishSelected ? 'Mumbai suburban' : 'मुंबई उपनगरीय'),
          ),
          DropdownMenuItem(
            value: 'Nanded',
            child: Text(_isEnglishSelected ? 'Nanded' : 'नांदेड'),
          ),
          DropdownMenuItem(
            value: 'Nandurbar',
            child: Text(_isEnglishSelected ? 'Nandurbar' : 'नंदुरबार'),
          ),
          DropdownMenuItem(
            value: 'Nagpur',
            child: Text(_isEnglishSelected ? 'Nagpur' : 'नागपुर'),
          ),
          DropdownMenuItem(
            value: 'Nashik',
            child: Text(_isEnglishSelected ? 'Nashik' : 'नाशिक'),
          ),
          DropdownMenuItem(
            value: 'Osmanabad',
            child: Text(_isEnglishSelected ? 'Osmanabad' : 'उस्मानाबाद'),
          ),
          DropdownMenuItem(
            value: 'Palghar',
            child: Text(_isEnglishSelected ? 'Palghar' : 'पालघर'),
          ),
          DropdownMenuItem(
            value: 'Parbhani',
            child: Text(_isEnglishSelected ? 'Parbhani' : 'परभणी'),
          ),
          DropdownMenuItem(
            value: 'Pune',
            child: Text(_isEnglishSelected ? 'Pune' : 'पुणे'),
          ),
          DropdownMenuItem(
            value: 'Raigad',
            child: Text(_isEnglishSelected ? 'Raigad' : 'रायगढ़'),
          ),
          DropdownMenuItem(
            value: 'Ratnagiri',
            child: Text(_isEnglishSelected ? 'Ratnagiri' : 'रत्नागिरी'),
          ),
          DropdownMenuItem(
            value: 'Sangli',
            child: Text(_isEnglishSelected ? 'Sangli' : 'सांगली'),
          ),
          DropdownMenuItem(
            value: 'Satara',
            child: Text(_isEnglishSelected ? 'Satara' : 'सातारा'),
          ),
          DropdownMenuItem(
            value: 'Sindhudurg',
            child: Text(_isEnglishSelected ? 'Sindhudurg' : 'सिंधुदुर्ग'),
          ),
          DropdownMenuItem(
            value: 'Solapur',
            child: Text(_isEnglishSelected ? 'Solapur' : 'सोलापूर'),
          ),
          DropdownMenuItem(
            value: 'Thane',
            child: Text(_isEnglishSelected ? 'Thane' : 'ठाणे'),
          ),
          DropdownMenuItem(
            value: 'Wardha',
            child: Text(_isEnglishSelected ? 'Wardha' : 'वर्धा'),
          ),
          DropdownMenuItem(
            value: 'Washim',
            child: Text(_isEnglishSelected ? 'Washim' : 'वाशिम'),
          ),
          DropdownMenuItem(
            value: 'Yavatmal',
            child: Text(_isEnglishSelected ? 'Yavatmal' : 'यवतमाळ'),
          ),
        ];
      case 'Manipur':
        return [
          DropdownMenuItem(
            value: 'Bishnupur',
            child: Text(_isEnglishSelected ? 'Bishnupur' : 'बिष्णुपुर'),
          ),
          DropdownMenuItem(
            value: 'Chandel',
            child: Text(_isEnglishSelected ? 'Chandel' : 'चंदेल'),
          ),
          DropdownMenuItem(
            value: 'Churachandpur',
            child: Text(_isEnglishSelected ? 'Churachandpur' : 'चूरचंदपुर'),
          ),
          DropdownMenuItem(
            value: 'Imphal East',
            child: Text(_isEnglishSelected ? 'Imphal East' : 'इंफाल पूर्व'),
          ),
          DropdownMenuItem(
            value: 'Imphal West',
            child: Text(_isEnglishSelected ? 'Imphal West' : 'इंफाल पश्चिम'),
          ),
          DropdownMenuItem(
            value: 'Jiribam',
            child: Text(_isEnglishSelected ? 'Jiribam' : 'जिरिबाम'),
          ),
          DropdownMenuItem(
            value: 'Kakching',
            child: Text(_isEnglishSelected ? 'Kakching' : 'कचिंग'),
          ),
          DropdownMenuItem(
            value: 'Kamjong',
            child: Text(_isEnglishSelected ? 'Kamjong' : 'काजोंग'),
          ),
          DropdownMenuItem(
            value: 'Kangpokpi',
            child: Text(_isEnglishSelected ? 'Kangpokpi' : 'कांगपोकी'),
          ),
          DropdownMenuItem(
            value: 'Noney',
            child: Text(_isEnglishSelected ? 'Noney' : 'नोनोय'),
          ),
          DropdownMenuItem(
            value: 'Pherzawl',
            child: Text(_isEnglishSelected ? 'Pherzawl' : 'फरजावल'),
          ),
          DropdownMenuItem(
            value: 'Senapati',
            child: Text(_isEnglishSelected ? 'Senapati' : 'सेनापति'),
          ),
          DropdownMenuItem(
            value: 'Tamenglong',
            child: Text(_isEnglishSelected ? 'Tamenglong' : 'तामेंगलोंग'),
          ),
          DropdownMenuItem(
            value: 'Tengnoupal',
            child: Text(_isEnglishSelected ? 'Tengnoupal' : 'टेंगनूपल'),
          ),
          DropdownMenuItem(
            value: 'Thoubal',
            child: Text(_isEnglishSelected ? 'Thoubal' : 'तूबल'),
          ),
          DropdownMenuItem(
            value: 'Ukhrul',
            child: Text(_isEnglishSelected ? 'Ukhrul' : 'उखरुल'),
          ),
        ];
      case 'Meghalaya':
        return [
          DropdownMenuItem(
            value: 'East Garo Hills',
            child: Text(
                _isEnglishSelected ? 'East Garo Hills' : 'ईस्ट गारो हिल्स'),
          ),
          DropdownMenuItem(
            value: 'East Khasi Hills',
            child: Text(
                _isEnglishSelected ? 'East Khasi Hills' : 'पूर्वी खाई हिल्स'),
          ),
          DropdownMenuItem(
            value: 'East Jaintia Hills',
            child: Text(_isEnglishSelected
                ? 'East Jaintia Hills'
                : 'पूर्वी जैंतिया हिल्स'),
          ),
          DropdownMenuItem(
            value: 'North Garo Hills',
            child: Text(
                _isEnglishSelected ? 'North Garo Hills' : 'उत्तरी गारो हिल्स'),
          ),
          DropdownMenuItem(
            value: 'Ri Bhoi',
            child: Text(_isEnglishSelected ? 'Ri Bhoi' : 'री भोई'),
          ),
          DropdownMenuItem(
            value: 'South Garo Hills',
            child: Text(
                _isEnglishSelected ? 'South Garo Hills' : 'दक्षिण गारो हिल्स'),
          ),
          DropdownMenuItem(
            value: 'South West Garo Hills',
            child: Text(_isEnglishSelected
                ? 'South West Garo Hills'
                : 'दक्षिण पश्चिम गारो हिल्स'),
          ),
          DropdownMenuItem(
            value: 'South West Khasi Hills',
            child: Text(_isEnglishSelected
                ? 'South West Khasi Hills'
                : 'दक्षिण पश्चिम खाई हिल्स'),
          ),
          DropdownMenuItem(
            value: 'West Jaintia Hills',
            child: Text(_isEnglishSelected
                ? 'West Jaintia Hills'
                : 'पश्चिम जैंतिया हिल्स'),
          ),
          DropdownMenuItem(
            value: 'West Garo Hills',
            child: Text(
                _isEnglishSelected ? 'West Garo Hills' : 'पश्चिम गारो हिल्स'),
          ),
          DropdownMenuItem(
            value: 'West Khasi Hills',
            child: Text(
                _isEnglishSelected ? 'West Khasi Hills' : 'पश्चिम खासी हिल्स'),
          ),
        ];
      case 'Mizoram':
        return [
          DropdownMenuItem(
            value: 'Aizawl',
            child: Text(_isEnglishSelected ? 'Aizawl' : 'आइजोल'),
          ),
          DropdownMenuItem(
            value: 'Champhai',
            child: Text(_isEnglishSelected ? 'Champhai' : 'चंपई'),
          ),
          DropdownMenuItem(
            value: 'Hnahthial',
            child: Text(_isEnglishSelected ? 'Hnahthial' : 'हथियल'),
          ),
          DropdownMenuItem(
            value: 'Khawzawl',
            child: Text(_isEnglishSelected ? 'Khawzawl' : 'खावजावल'),
          ),
          DropdownMenuItem(
            value: 'Kolasib',
            child: Text(_isEnglishSelected ? 'Kolasib' : 'कोलसिब'),
          ),
          DropdownMenuItem(
            value: 'Lawngtlai',
            child: Text(_isEnglishSelected ? 'Lawngtlai' : 'लंगतलाई'),
          ),
          DropdownMenuItem(
            value: 'Lunglei',
            child: Text(_isEnglishSelected ? 'Lunglei' : 'लुंगलेई'),
          ),
          DropdownMenuItem(
            value: 'Mamit',
            child: Text(_isEnglishSelected ? 'Mamit' : 'मैअमित'),
          ),
          DropdownMenuItem(
            value: 'Saiha',
            child: Text(_isEnglishSelected ? 'Saiha' : 'सैहा'),
          ),
          DropdownMenuItem(
            value: 'Saitual',
            child: Text(_isEnglishSelected ? 'Saitual' : 'सैतुअल'),
          ),
          DropdownMenuItem(
            value: 'Serchhip',
            child: Text(_isEnglishSelected ? 'Serchhip' : 'सेरचिप'),
          ),
        ];
      case 'Nagaland':
        return [
          DropdownMenuItem(
            value: 'Dimapur',
            child: Text(_isEnglishSelected ? 'Dimapur' : 'दीमापुर'),
          ),
          DropdownMenuItem(
            value: 'Kiphire',
            child: Text(_isEnglishSelected ? 'Kiphire' : 'किपशायर'),
          ),
          DropdownMenuItem(
            value: 'Kohima',
            child: Text(_isEnglishSelected ? 'Kohima' : 'कोहिमा'),
          ),
          DropdownMenuItem(
            value: 'Longleng',
            child: Text(_isEnglishSelected ? 'Longleng' : 'लांगलेंग'),
          ),
          DropdownMenuItem(
            value: 'Mokokchung',
            child: Text(_isEnglishSelected ? 'Mokokchung' : 'मोकोकचुंग'),
          ),
          DropdownMenuItem(
            value: 'Mon',
            child: Text(_isEnglishSelected ? 'Mon' : 'सोम'),
          ),
          DropdownMenuItem(
            value: 'Noklak',
            child: Text(_isEnglishSelected ? 'Noklak' : 'नोकलक'),
          ),
          DropdownMenuItem(
            value: 'Peren',
            child: Text(_isEnglishSelected ? 'Peren' : 'पेरेन'),
          ),
          DropdownMenuItem(
            value: 'Phek',
            child: Text(_isEnglishSelected ? 'Phek' : 'फेक'),
          ),
          DropdownMenuItem(
            value: 'Tuensang',
            child: Text(_isEnglishSelected ? 'Tuensang' : 'तुएनसांग'),
          ),
          DropdownMenuItem(
            value: 'Wokha',
            child: Text(_isEnglishSelected ? 'Wokha' : 'वोखा'),
          ),
          DropdownMenuItem(
            value: 'Zunheboto',
            child: Text(_isEnglishSelected ? 'Zunheboto' : 'जुनहेबोटो'),
          ),
        ];
      case 'Odisha':
        return [
          DropdownMenuItem(
            value: 'Angul',
            child: Text(_isEnglishSelected ? 'Angul' : 'अनुगुळ'),
          ),
          DropdownMenuItem(
            value: 'Boudh',
            child: Text(_isEnglishSelected ? 'Boudh' : 'बौध'),
          ),
          DropdownMenuItem(
            value: 'Bhadrak',
            child: Text(_isEnglishSelected ? 'Bhadrak' : 'भद्रक'),
          ),
          DropdownMenuItem(
            value: 'Balangir',
            child: Text(_isEnglishSelected ? 'Balangir' : 'बलांगीर।'),
          ),
          DropdownMenuItem(
            value: 'Bargarh',
            child: Text(_isEnglishSelected ? 'Bargarh' : 'बरगढ़'),
          ),
          DropdownMenuItem(
            value: 'Balasore',
            child: Text(_isEnglishSelected ? 'Balasore' : 'बालासोर'),
          ),
          DropdownMenuItem(
            value: 'Cuttack',
            child: Text(_isEnglishSelected ? 'Cuttack' : 'कटक'),
          ),
          DropdownMenuItem(
            value: 'Debagarh',
            child: Text(_isEnglishSelected ? 'Debagarh' : 'देबागढ़।'),
          ),
          DropdownMenuItem(
            value: 'Dhenkanal',
            child: Text(_isEnglishSelected ? 'Dhenkanal' : 'ढेंकानाल'),
          ),
          DropdownMenuItem(
            value: 'Ganjam',
            child: Text(_isEnglishSelected ? 'Ganjam' : 'गंजाम'),
          ),
          DropdownMenuItem(
            value: 'Gajapati',
            child: Text(_isEnglishSelected ? 'Gajapati' : 'गजपति'),
          ),
          DropdownMenuItem(
            value: 'Jharsuguda',
            child: Text(_isEnglishSelected ? 'Jharsuguda' : 'झारसुगुड़ा'),
          ),
          DropdownMenuItem(
            value: 'Jajpur',
            child: Text(_isEnglishSelected ? 'Jajpur' : 'जाजपुर'),
          ),
          DropdownMenuItem(
            value: 'Jagatsinghpur',
            child: Text(_isEnglishSelected ? 'Jagatsinghpur' : 'जगतसिंहपुर'),
          ),
          DropdownMenuItem(
            value: 'Khordha',
            child: Text(_isEnglishSelected ? 'Khordha' : 'खोर्धा'),
          ),
          DropdownMenuItem(
            value: 'Kendujhar',
            child: Text(_isEnglishSelected ? 'Kendujhar' : 'केंदुझर'),
          ),
          DropdownMenuItem(
            value: 'Kalahandi',
            child: Text(_isEnglishSelected ? 'Kalahandi' : 'कालाहांडी'),
          ),
          DropdownMenuItem(
            value: 'Kandhamal',
            child: Text(_isEnglishSelected ? 'Kandhamal' : 'कंधमाल'),
          ),
          DropdownMenuItem(
            value: 'Koraput',
            child: Text(_isEnglishSelected ? 'Koraput' : 'कोरापुट'),
          ),
          DropdownMenuItem(
            value: 'Kendrapara',
            child: Text(_isEnglishSelected ? 'Kendrapara' : 'केंद्रपाड़ा'),
          ),
          DropdownMenuItem(
            value: 'Malkangiri',
            child: Text(_isEnglishSelected ? 'Malkangiri' : 'मलकानगिरी'),
          ),
          DropdownMenuItem(
            value: 'Mayurbhanj',
            child: Text(_isEnglishSelected ? 'Mayurbhanj' : 'मयूरभंज'),
          ),
          DropdownMenuItem(
            value: 'Nabarangpur',
            child: Text(_isEnglishSelected ? 'Nabarangpur' : 'नारंगपुर'),
          ),
          DropdownMenuItem(
            value: 'Nuapada',
            child: Text(_isEnglishSelected ? 'Nuapada' : 'नुआपाड़ा'),
          ),
          DropdownMenuItem(
            value: 'Nayagarh',
            child: Text(_isEnglishSelected ? 'Nayagarh' : 'नयागढ़'),
          ),
          DropdownMenuItem(
            value: 'Puri',
            child: Text(_isEnglishSelected ? 'Puri' : 'पुरी'),
          ),
          DropdownMenuItem(
            value: 'Rayagada',
            child: Text(_isEnglishSelected ? 'Rayagada' : 'रायगढ़'),
          ),
          DropdownMenuItem(
            value: 'Sambalpur',
            child: Text(_isEnglishSelected ? 'Sambalpur' : 'संबलपुर।'),
          ),
          DropdownMenuItem(
            value: 'Subarnapur',
            child: Text(_isEnglishSelected ? 'Subarnapur' : 'सुवर्णपुर'),
          ),
          DropdownMenuItem(
            value: 'Sundargarh',
            child: Text(_isEnglishSelected ? 'Sundargarh' : 'सुंदरगढ़'),
          ),
        ];
      case 'Punjab':
        return [
          DropdownMenuItem(
            value: 'Amritsar',
            child: Text(_isEnglishSelected ? 'Amritsar' : 'अमृतसर'),
          ),
          DropdownMenuItem(
            value: 'Barnala',
            child: Text(_isEnglishSelected ? 'Barnala' : 'बरनाला'),
          ),
          DropdownMenuItem(
            value: 'Bathinda',
            child: Text(_isEnglishSelected ? 'Bathinda' : 'बठिण्डा'),
          ),
          DropdownMenuItem(
            value: 'Firozpur',
            child: Text(_isEnglishSelected ? 'Firozpur' : 'फिरोजपुर'),
          ),
          DropdownMenuItem(
            value: 'Faridkot',
            child: Text(_isEnglishSelected ? 'Faridkot' : 'फरीदकोट'),
          ),
          DropdownMenuItem(
            value: 'Fatehgarh Sahib',
            child:
                Text(_isEnglishSelected ? 'Fatehgarh Sahib' : 'फतेहगढ़ साहिब'),
          ),
          DropdownMenuItem(
            value: 'Fazilka',
            child: Text(_isEnglishSelected ? 'Fazilka' : 'फाजिल्का'),
          ),
          DropdownMenuItem(
            value: 'Gurdaspur',
            child: Text(_isEnglishSelected ? 'Gurdaspur' : 'गुरदासपुर'),
          ),
          DropdownMenuItem(
            value: 'Hoshiarpur',
            child: Text(_isEnglishSelected ? 'Hoshiarpur' : 'होशियारपुर।'),
          ),
          DropdownMenuItem(
            value: 'Jalandhar',
            child: Text(_isEnglishSelected ? 'Jalandhar' : 'जालंधर'),
          ),
          DropdownMenuItem(
            value: 'Kapurthala',
            child: Text(_isEnglishSelected ? 'Kapurthala' : 'कपूरथला'),
          ),
          DropdownMenuItem(
            value: 'Ludhiana',
            child: Text(_isEnglishSelected ? 'Ludhiana' : 'लुधियाना'),
          ),
          DropdownMenuItem(
            value: 'Mansa',
            child: Text(_isEnglishSelected ? 'Mansa' : 'मनसा'),
          ),
          DropdownMenuItem(
            value: 'Moga',
            child: Text(_isEnglishSelected ? 'Moga' : 'मोगा'),
          ),
          DropdownMenuItem(
            value: 'Sri Muktsar Sahib',
            child: Text(_isEnglishSelected
                ? 'Sri Muktsar Sahib'
                : 'श्री मुक्तसर साहिब'),
          ),
          DropdownMenuItem(
            value: 'Pathankot',
            child: Text(_isEnglishSelected ? 'Pathankot' : 'पठानकोट'),
          ),
          DropdownMenuItem(
            value: 'Patiala',
            child: Text(_isEnglishSelected ? 'Patiala' : 'पटियाला'),
          ),
          DropdownMenuItem(
            value: 'Rupnagar',
            child: Text(_isEnglishSelected ? 'Rupnagar' : 'रूपनगर'),
          ),
          DropdownMenuItem(
            value: 'Sahibzada Ajit Singh Nagar',
            child: Text(_isEnglishSelected
                ? 'Sahibzada Ajit Singh Nagar'
                : 'साहिबजादा अजीत सिंह नगर'),
          ),
          DropdownMenuItem(
            value: 'Sangrur',
            child: Text(_isEnglishSelected ? 'Sangrur' : 'संगरूर'),
          ),
          DropdownMenuItem(
            value: 'Shahid Bhagat Singh Nagar',
            child: Text(_isEnglishSelected
                ? 'Shahid Bhagat Singh Nagar'
                : 'शाहिद भगत सिंह नगर'),
          ),
          DropdownMenuItem(
            value: 'Tarn Taran',
            child: Text(_isEnglishSelected ? 'Tarn Taran' : 'तरन तरन'),
          ),
        ];
      case 'Rajasthan':
        return [
          DropdownMenuItem(
            value: 'Ajmer',
            child: Text(_isEnglishSelected ? 'Ajmer' : 'अजमेर'),
          ),
          DropdownMenuItem(
            value: 'Alwar',
            child: Text(_isEnglishSelected ? 'Alwar' : 'अलवर'),
          ),
          DropdownMenuItem(
            value: 'Bikaner',
            child: Text(_isEnglishSelected ? 'Bikaner' : 'बीकानेर'),
          ),
          DropdownMenuItem(
            value: 'Barmer',
            child: Text(_isEnglishSelected ? 'Barmer' : 'बाड़मेर'),
          ),
          DropdownMenuItem(
            value: 'Banswara',
            child: Text(_isEnglishSelected ? 'Banswara' : 'बांसवाड़ा।'),
          ),
          DropdownMenuItem(
            value: 'Bharatpur',
            child: Text(_isEnglishSelected ? 'Bharatpur' : 'भरतपुर'),
          ),
          DropdownMenuItem(
            value: 'Baran',
            child: Text(_isEnglishSelected ? 'Baran' : 'बारां'),
          ),
          DropdownMenuItem(
            value: 'Bundi',
            child: Text(_isEnglishSelected ? 'Bundi' : 'बूंदी'),
          ),
          DropdownMenuItem(
            value: 'Bhilwara',
            child: Text(_isEnglishSelected ? 'Bhilwara' : 'भीलवाड़ा'),
          ),
          DropdownMenuItem(
            value: 'Churu',
            child: Text(_isEnglishSelected ? 'Churu' : 'चूरू।'),
          ),
          DropdownMenuItem(
            value: 'Chittorgarh',
            child: Text(_isEnglishSelected ? 'Chittorgarh' : 'चित्तौड़गढ़'),
          ),
          DropdownMenuItem(
            value: 'Dausa',
            child: Text(_isEnglishSelected ? 'Dausa' : 'दौसा।'),
          ),
          DropdownMenuItem(
            value: 'Dholpur',
            child: Text(_isEnglishSelected ? 'Dholpur' : 'धौलपुर'),
          ),
          DropdownMenuItem(
            value: 'Dungarpur',
            child: Text(_isEnglishSelected ? 'Dungarpur' : 'डूंगरपुर।'),
          ),
          DropdownMenuItem(
            value: 'Ganganagar',
            child: Text(_isEnglishSelected ? 'Ganganagar' : 'गंगानगर'),
          ),
          DropdownMenuItem(
            value: 'Hanumangarh',
            child: Text(_isEnglishSelected ? 'Hanumangarh' : 'हनुमानगढ़'),
          ),
          DropdownMenuItem(
            value: 'Jhunjhunu',
            child: Text(_isEnglishSelected ? 'Jhunjhunu' : 'झुंझुनू'),
          ),
          DropdownMenuItem(
            value: 'Jalore',
            child: Text(_isEnglishSelected ? 'Jalore' : 'जालौर'),
          ),
          DropdownMenuItem(
            value: 'Jodhpur',
            child: Text(_isEnglishSelected ? 'Jodhpur' : 'जोधपुर'),
          ),
          DropdownMenuItem(
            value: 'Jaipur',
            child: Text(_isEnglishSelected ? 'Jaipur' : 'जयपुर'),
          ),
          DropdownMenuItem(
            value: 'Jaisalmer',
            child: Text(_isEnglishSelected ? 'Jaisalmer' : 'जैसलमेर'),
          ),
          DropdownMenuItem(
            value: 'Jhalawar',
            child: Text(_isEnglishSelected ? 'Jhalawar' : 'झालावाड़'),
          ),
          DropdownMenuItem(
            value: 'Karauli',
            child: Text(_isEnglishSelected ? 'Karauli' : 'करौली'),
          ),
          DropdownMenuItem(
            value: 'Kota',
            child: Text(_isEnglishSelected ? 'Kota' : 'कोटा'),
          ),
          DropdownMenuItem(
            value: 'Nagaur',
            child: Text(_isEnglishSelected ? 'Nagaur' : 'नागौर।'),
          ),
          DropdownMenuItem(
            value: 'Pali',
            child: Text(_isEnglishSelected ? 'Pali' : 'पाली'),
          ),
          DropdownMenuItem(
            value: 'Pratapgarh',
            child: Text(_isEnglishSelected ? 'Pratapgarh' : 'प्रतापगढ़'),
          ),
          DropdownMenuItem(
            value: 'Rajsamand',
            child: Text(_isEnglishSelected ? 'Rajsamand' : 'राजसमंद।'),
          ),
          DropdownMenuItem(
            value: 'Sikar',
            child: Text(_isEnglishSelected ? 'Sikar' : 'सीकर'),
          ),
          DropdownMenuItem(
            value: 'Sawai Madhopur',
            child: Text(_isEnglishSelected ? 'Sawai Madhopur' : 'सवाई माधोपुर'),
          ),
          DropdownMenuItem(
            value: 'Sirohi',
            child: Text(_isEnglishSelected ? 'Sirohi' : 'सिरोही'),
          ),
          DropdownMenuItem(
            value: 'Tonk',
            child: Text(_isEnglishSelected ? 'Tonk' : 'टोंक'),
          ),
          DropdownMenuItem(
            value: 'Udaipur',
            child: Text(_isEnglishSelected ? 'Udaipur' : 'उदयपुर'),
          ),
        ];
      case 'Sikkim':
        return [
          DropdownMenuItem(
            value: 'East Sikkim',
            child: Text(_isEnglishSelected ? 'East Sikkim' : 'पूर्वी सिक्किम'),
          ),
          DropdownMenuItem(
            value: 'North Sikkim',
            child: Text(_isEnglishSelected ? 'North Sikkim' : 'उत्तरी सिक्किम'),
          ),
          DropdownMenuItem(
            value: 'South Sikkim',
            child: Text(_isEnglishSelected ? 'South Sikkim' : 'दक्षिण सिक्किम'),
          ),
          DropdownMenuItem(
            value: 'West Sikkim',
            child: Text(_isEnglishSelected ? 'West Sikkim' : 'पश्चिम सिक्किम'),
          ),
        ];
      case 'Tamil Nadu':
        return [
          DropdownMenuItem(
            value: 'riyalur',
            child: Text(_isEnglishSelected ? 'riyalur' : 'रियालुर'),
          ),
          DropdownMenuItem(
            value: 'Chengalpattu',
            child: Text(_isEnglishSelected ? 'Chengalpattu' : 'चेंगलपट्टू'),
          ),
          DropdownMenuItem(
            value: 'Chennai',
            child: Text(_isEnglishSelected ? 'Chennai' : 'चेन्नई'),
          ),
          DropdownMenuItem(
            value: 'Coimbatore',
            child: Text(_isEnglishSelected ? 'Coimbatore' : 'कोयम्बटूर'),
          ),
          DropdownMenuItem(
            value: 'Cuddalore',
            child: Text(_isEnglishSelected ? 'Cuddalore' : 'कुड्डालोर'),
          ),
          DropdownMenuItem(
            value: 'Dharmapuri',
            child: Text(_isEnglishSelected ? 'Dharmapuri' : 'धरमपुरी'),
          ),
          DropdownMenuItem(
            value: 'Dindigul',
            child: Text(_isEnglishSelected ? 'Dindigul' : 'डिंडीगुल'),
          ),
          DropdownMenuItem(
            value: 'Erode',
            child: Text(_isEnglishSelected ? 'Erode' : 'इरोड'),
          ),
          DropdownMenuItem(
            value: 'Kallakurichi',
            child: Text(_isEnglishSelected ? 'Kallakurichi' : 'कल्किचुरी'),
          ),
          DropdownMenuItem(
            value: 'Kanchipuram',
            child: Text(_isEnglishSelected ? 'Kanchipuram' : 'कांचीपुरम'),
          ),
          DropdownMenuItem(
            value: 'Kanyakumari',
            child: Text(_isEnglishSelected ? 'Kanyakumari' : 'कन्याकुमारी'),
          ),
          DropdownMenuItem(
            value: 'Karur',
            child: Text(_isEnglishSelected ? 'Karur' : 'करूर'),
          ),
          DropdownMenuItem(
            value: 'Krishnagiri',
            child: Text(_isEnglishSelected ? 'Krishnagiri' : 'कृष्णागिरी'),
          ),
          DropdownMenuItem(
            value: 'Madurai',
            child: Text(_isEnglishSelected ? 'Madurai' : 'मदुरै'),
          ),
          DropdownMenuItem(
            value: 'Mayiladuthurai',
            child: Text(_isEnglishSelected ? 'Mayiladuthurai' : 'माइलदूतुराई'),
          ),
          DropdownMenuItem(
            value: 'Nagapattinam',
            child: Text(_isEnglishSelected ? 'Nagapattinam' : 'नागपट्टिनम'),
          ),
          DropdownMenuItem(
            value: 'Nilgiris',
            child: Text(_isEnglishSelected ? 'Nilgiris' : 'नीलगिरि'),
          ),
          DropdownMenuItem(
            value: 'Namakkal',
            child: Text(_isEnglishSelected ? 'Namakkal' : 'नमककल'),
          ),
          DropdownMenuItem(
            value: 'Perambalur',
            child: Text(_isEnglishSelected ? 'Perambalur' : 'पेराम्बलुर'),
          ),
          DropdownMenuItem(
            value: 'Pudukkottai',
            child: Text(_isEnglishSelected ? 'Pudukkottai' : 'पुडुकोट्टई'),
          ),
          DropdownMenuItem(
            value: 'Ramanathapuram',
            child: Text(_isEnglishSelected ? 'Ramanathapuram' : 'रामनाथपुरम'),
          ),
          DropdownMenuItem(
            value: 'Ranipet',
            child: Text(_isEnglishSelected ? 'Ranipet' : 'रानीपेट'),
          ),
          DropdownMenuItem(
            value: 'Salem',
            child: Text(_isEnglishSelected ? 'Salem' : 'सलेम'),
          ),
          DropdownMenuItem(
            value: 'Sivaganga',
            child: Text(_isEnglishSelected ? 'Sivaganga' : 'शिवगंगा'),
          ),
          DropdownMenuItem(
            value: 'Tenkasi',
            child: Text(_isEnglishSelected ? 'Tenkasi' : 'तेनकासी'),
          ),
          DropdownMenuItem(
            value: 'Tirupur',
            child: Text(_isEnglishSelected ? 'Tirupur' : 'तिरुपुर'),
          ),
          DropdownMenuItem(
            value: 'Tiruchirappalli',
            child:
                Text(_isEnglishSelected ? 'Tiruchirappalli' : 'तिरुचिरापल्ली'),
          ),
          DropdownMenuItem(
            value: 'Theni',
            child: Text(_isEnglishSelected ? 'Theni' : 'थेनी'),
          ),
          DropdownMenuItem(
            value: 'Tirunelveli',
            child: Text(_isEnglishSelected ? 'Tirunelveli' : 'तिरुनेलवेली'),
          ),
          DropdownMenuItem(
            value: 'Thanjavur',
            child: Text(_isEnglishSelected ? 'Thanjavur' : 'तंजावुर'),
          ),
          DropdownMenuItem(
            value: 'Thoothukudi',
            child: Text(_isEnglishSelected ? 'Thoothukudi' : 'थुथुकुडी'),
          ),
          DropdownMenuItem(
            value: 'Tirupattur',
            child: Text(_isEnglishSelected ? 'Tirupattur' : 'तिरुपतितुर'),
          ),
          DropdownMenuItem(
            value: 'Tiruvallur',
            child: Text(_isEnglishSelected ? 'Tiruvallur' : 'तिरुवल्लूर'),
          ),
          DropdownMenuItem(
            value: 'Tiruvarur',
            child: Text(_isEnglishSelected ? 'Tiruvarur' : 'तिरुवरुर'),
          ),
          DropdownMenuItem(
            value: 'Tiruvannamalai',
            child: Text(_isEnglishSelected ? 'Tiruvannamalai' : 'तिरुवनमलाई'),
          ),
          DropdownMenuItem(
            value: 'Vellore',
            child: Text(_isEnglishSelected ? 'Vellore' : 'वेल्लोर'),
          ),
          DropdownMenuItem(
            value: 'Viluppuram',
            child: Text(_isEnglishSelected ? 'Viluppuram' : 'विल्रूपपुरम'),
          ),
          DropdownMenuItem(
            value: 'Virudhunagar',
            child: Text(_isEnglishSelected ? 'Virudhunagar' : 'विरुधुनगर'),
          ),
        ];
      case 'Telangana':
        return [
          DropdownMenuItem(
            value: 'Adilabad',
            child: Text(_isEnglishSelected ? 'Adilabad' : 'आदिलाबाद'),
          ),
          DropdownMenuItem(
            value: 'Komaram Bheem',
            child: Text(_isEnglishSelected ? 'Komaram Bheem' : 'कोमाराम भीम'),
          ),
          DropdownMenuItem(
            value: 'Bhadradri Kothagudem',
            child: Text(_isEnglishSelected
                ? 'Bhadradri Kothagudem'
                : 'भद्राद्री कोठागुडेम'),
          ),
          DropdownMenuItem(
            value: 'Hyderabad',
            child: Text(_isEnglishSelected ? 'Hyderabad' : 'हैदराबाद'),
          ),
          DropdownMenuItem(
            value: 'Jagtial',
            child: Text(_isEnglishSelected ? 'Jagtial' : 'जगतिल'),
          ),
          DropdownMenuItem(
            value: 'Jangaon',
            child: Text(_isEnglishSelected ? 'Jangaon' : 'जनगांव'),
          ),
          DropdownMenuItem(
            value: 'Jayashankar Bhupalpally',
            child: Text(_isEnglishSelected
                ? 'Jayashankar Bhupalpally'
                : 'जयशंकर भूपालली'),
          ),
          DropdownMenuItem(
            value: 'Jogulamba Gadwal',
            child:
                Text(_isEnglishSelected ? 'Jogulamba Gadwal' : 'जोगुलबा गडवाल'),
          ),
          DropdownMenuItem(
            value: 'Kamareddy',
            child: Text(_isEnglishSelected ? 'Kamareddy' : 'कामरेड्डी'),
          ),
          DropdownMenuItem(
            value: 'Karimnagar',
            child: Text(_isEnglishSelected ? 'Karimnagar' : 'करीमनगर'),
          ),
          DropdownMenuItem(
            value: 'Khammam',
            child: Text(_isEnglishSelected ? 'Khammam' : 'खम्मम'),
          ),
          DropdownMenuItem(
            value: 'Mahabubabad',
            child: Text(_isEnglishSelected ? 'Mahabubabad' : 'महबूबाबाद'),
          ),
          DropdownMenuItem(
            value: 'Mahbubnagar',
            child: Text(_isEnglishSelected ? 'Mahbubnagar' : 'महबूबनगर'),
          ),
          DropdownMenuItem(
            value: 'Mancherial',
            child: Text(_isEnglishSelected ? 'Mancherial' : 'मंचेरियल'),
          ),
          DropdownMenuItem(
            value: 'Medak',
            child: Text(_isEnglishSelected ? 'Medak' : 'मेडक'),
          ),
          DropdownMenuItem(
            value: 'Medchal-Malkajgiri',
            child: Text(
                _isEnglishSelected ? 'Medchal-Malkajgiri' : 'मेचल-मलकाजगिरी'),
          ),
          DropdownMenuItem(
            value: 'Mulugu',
            child: Text(_isEnglishSelected ? 'Mulugu' : 'मुलुगु'),
          ),
          DropdownMenuItem(
            value: 'Nalgonda',
            child: Text(_isEnglishSelected ? 'Nalgonda' : 'नालगोंडा'),
          ),
          DropdownMenuItem(
            value: 'Narayanpet',
            child: Text(_isEnglishSelected ? 'Narayanpet' : 'नारायणपेट'),
          ),
          DropdownMenuItem(
            value: 'Nagarkurnool',
            child: Text(_isEnglishSelected ? 'Nagarkurnool' : 'नगरकुरनूल'),
          ),
          DropdownMenuItem(
            value: 'Nirmal',
            child: Text(_isEnglishSelected ? 'Nirmal' : 'निर्मल'),
          ),
          DropdownMenuItem(
            value: 'Nizamabad',
            child: Text(_isEnglishSelected ? 'Nizamabad' : 'निजामाबाद'),
          ),
          DropdownMenuItem(
            value: 'Peddapalli',
            child: Text(_isEnglishSelected ? 'Peddapalli' : 'पेडापल्ली'),
          ),
          DropdownMenuItem(
            value: 'Rajanna Sircilla',
            child: Text(
                _isEnglishSelected ? 'Rajanna Sircilla' : 'राजोआना सिरसिला'),
          ),
          DropdownMenuItem(
            value: 'Ranga Reddy',
            child: Text(_isEnglishSelected ? 'Ranga Reddy' : 'रंगा रेड्डी'),
          ),
          DropdownMenuItem(
            value: 'Sangareddy',
            child: Text(_isEnglishSelected ? 'Sangareddy' : 'सांगारेड्डी'),
          ),
          DropdownMenuItem(
            value: 'Siddipet',
            child: Text(_isEnglishSelected ? 'Siddipet' : 'सिद्दीपेट'),
          ),
          DropdownMenuItem(
            value: 'Suryapet',
            child: Text(_isEnglishSelected ? 'Suryapet' : 'सूर्यपेट'),
          ),
          DropdownMenuItem(
            value: 'Vikarabad',
            child: Text(_isEnglishSelected ? 'Vikarabad' : 'विकाबाद'),
          ),
          DropdownMenuItem(
            value: 'Wanaparthy',
            child: Text(_isEnglishSelected ? 'Wanaparthy' : 'वानापारथी'),
          ),
          DropdownMenuItem(
            value: 'Warangal Urban',
            child: Text(_isEnglishSelected ? 'Warangal Urban' : 'वारंगल शहरी'),
          ),
          DropdownMenuItem(
            value: 'Warangal Rural',
            child:
                Text(_isEnglishSelected ? 'Warangal Rural' : 'वारंगल ग्रामीण'),
          ),
          DropdownMenuItem(
            value: 'Yadadri Bhuvanagiri',
            child: Text(
                _isEnglishSelected ? 'Yadadri Bhuvanagiri' : 'याद्री भुवनगिरी'),
          ),
        ];
      case 'Tripura':
        return [
          DropdownMenuItem(
            value: 'Dhalai',
            child: Text(_isEnglishSelected ? 'Dhalai' : 'धलाई'),
          ),
          DropdownMenuItem(
            value: 'Gomati',
            child: Text(_isEnglishSelected ? 'Gomati' : 'गोमती'),
          ),
          DropdownMenuItem(
            value: 'Khowai',
            child: Text(_isEnglishSelected ? 'Khowai' : 'खोवाई'),
          ),
          DropdownMenuItem(
            value: 'North Tripura',
            child:
                Text(_isEnglishSelected ? 'North Tripura' : 'उत्तर त्रिपुरा'),
          ),
          DropdownMenuItem(
            value: 'Sepahijala',
            child: Text(_isEnglishSelected ? 'Sepahijala' : 'सेफिजला'),
          ),
          DropdownMenuItem(
            value: 'South Tripura',
            child:
                Text(_isEnglishSelected ? 'South Tripura' : 'दक्षिण त्रिपुरा'),
          ),
          DropdownMenuItem(
            value: 'Unokoti',
            child: Text(_isEnglishSelected ? 'Unokoti' : 'यूनोकोटी'),
          ),
          DropdownMenuItem(
            value: 'West Tripura',
            child:
                Text(_isEnglishSelected ? 'West Tripura' : 'पश्चिम त्रिपुरा'),
          ),
        ];
      case 'Uttar Pradesh':
        return [
          DropdownMenuItem(
            value: 'Agra',
            child: Text(_isEnglishSelected ? 'Agra' : 'आगरा'),
          ),
          DropdownMenuItem(
            value: 'Aligarh',
            child: Text(_isEnglishSelected ? 'Aligarh' : 'अलीगढ़'),
          ),
          DropdownMenuItem(
            value: 'Prayagraj [18]',
            child:
                Text(_isEnglishSelected ? 'Prayagraj [18]' : 'प्रयागराज [18]'),
          ),
          DropdownMenuItem(
            value: 'Ambedkar Nagar',
            child: Text(_isEnglishSelected ? 'Ambedkar Nagar' : 'अंबेडकर नगर'),
          ),
          DropdownMenuItem(
            value: 'Amethi',
            child: Text(_isEnglishSelected ? 'Amethi' : 'अमेठी।'),
          ),
          DropdownMenuItem(
            value: 'Amroha',
            child: Text(_isEnglishSelected ? 'Amroha' : 'अमरोहा।'),
          ),
          DropdownMenuItem(
            value: 'Auraiya',
            child: Text(_isEnglishSelected ? 'Auraiya' : 'औरैया'),
          ),
          DropdownMenuItem(
            value: 'Azamgarh',
            child: Text(_isEnglishSelected ? 'Azamgarh' : 'आजमगढ़'),
          ),
          DropdownMenuItem(
            value: 'Bagpat',
            child: Text(_isEnglishSelected ? 'Bagpat' : 'बागपत'),
          ),
          DropdownMenuItem(
            value: 'Bahraich',
            child: Text(_isEnglishSelected ? 'Bahraich' : 'बहराइच'),
          ),
          DropdownMenuItem(
            value: 'Ballia',
            child: Text(_isEnglishSelected ? 'Ballia' : 'बलिया'),
          ),
          DropdownMenuItem(
            value: 'Balrampur',
            child: Text(_isEnglishSelected ? 'Balrampur' : 'बलरामपुर।'),
          ),
          DropdownMenuItem(
            value: 'Banda',
            child: Text(_isEnglishSelected ? 'Banda' : 'बांदा'),
          ),
          DropdownMenuItem(
            value: 'Barabanki',
            child: Text(_isEnglishSelected ? 'Barabanki' : 'बाराबंकी'),
          ),
          DropdownMenuItem(
            value: 'Bareilly',
            child: Text(_isEnglishSelected ? 'Bareilly' : 'बरेली'),
          ),
          DropdownMenuItem(
            value: 'Basti',
            child: Text(_isEnglishSelected ? 'Basti' : 'बस्ती'),
          ),
          DropdownMenuItem(
            value: 'Bhadohi',
            child: Text(_isEnglishSelected ? 'Bhadohi' : 'भदोही'),
          ),
          DropdownMenuItem(
            value: 'Bijnor',
            child: Text(_isEnglishSelected ? 'Bijnor' : 'बिजनौर'),
          ),
          DropdownMenuItem(
            value: 'Budaun',
            child: Text(_isEnglishSelected ? 'Budaun' : 'बुडयून'),
          ),
          DropdownMenuItem(
            value: 'Bulandshahr',
            child: Text(_isEnglishSelected ? 'Bulandshahr' : 'बुलंदशहर'),
          ),
          DropdownMenuItem(
            value: 'Chandauli',
            child: Text(_isEnglishSelected ? 'Chandauli' : 'चंदौली।'),
          ),
          DropdownMenuItem(
            value: 'Chitrakoot',
            child: Text(_isEnglishSelected ? 'Chitrakoot' : 'चित्रकूट।'),
          ),
          DropdownMenuItem(
            value: 'Deoria',
            child: Text(_isEnglishSelected ? 'Deoria' : 'देवरिया'),
          ),
          DropdownMenuItem(
            value: 'Etah',
            child: Text(_isEnglishSelected ? 'Etah' : 'एटा'),
          ),
          DropdownMenuItem(
            value: 'Etawah',
            child: Text(_isEnglishSelected ? 'Etawah' : 'इटावा'),
          ),
          DropdownMenuItem(
            value: 'Ayodhya',
            child: Text(_isEnglishSelected ? 'Ayodhya' : 'अयोध्या'),
          ),
          DropdownMenuItem(
            value: 'Farrukhabad',
            child: Text(_isEnglishSelected ? 'Farrukhabad' : 'फर्रुखाबाद'),
          ),
          DropdownMenuItem(
            value: 'Fatehpur',
            child: Text(_isEnglishSelected ? 'Fatehpur' : 'फतेहपुर'),
          ),
          DropdownMenuItem(
            value: 'Firozabad',
            child: Text(_isEnglishSelected ? 'Firozabad' : 'फीरोजाबाद'),
          ),
          DropdownMenuItem(
            value: 'Gautam Buddh Nagar',
            child: Text(
                _isEnglishSelected ? 'Gautam Buddh Nagar' : 'गौतमबुद्धनगर'),
          ),
          DropdownMenuItem(
            value: 'Ghaziabad',
            child: Text(_isEnglishSelected ? 'Ghaziabad' : 'गाजियाबाद'),
          ),
          DropdownMenuItem(
            value: 'Ghazipur',
            child: Text(_isEnglishSelected ? 'Ghazipur' : 'गाजीपुर'),
          ),
          DropdownMenuItem(
            value: 'Gonda',
            child: Text(_isEnglishSelected ? 'Gonda' : 'गोंडा'),
          ),
          DropdownMenuItem(
            value: 'Gorakhpur',
            child: Text(_isEnglishSelected ? 'Gorakhpur' : 'गोरखपुर'),
          ),
          DropdownMenuItem(
            value: 'Hamirpur',
            child: Text(_isEnglishSelected ? 'Hamirpur' : 'हमीरपुर'),
          ),
          DropdownMenuItem(
            value: 'Hapur',
            child: Text(_isEnglishSelected ? 'Hapur' : 'हापुड़'),
          ),
          DropdownMenuItem(
            value: 'Hardoi',
            child: Text(_isEnglishSelected ? 'Hardoi' : 'हरदोई'),
          ),
          DropdownMenuItem(
            value: 'Hathras',
            child: Text(_isEnglishSelected ? 'Hathras' : 'हाथरस'),
          ),
          DropdownMenuItem(
            value: 'Jalaun',
            child: Text(_isEnglishSelected ? 'Jalaun' : 'जालौन'),
          ),
          DropdownMenuItem(
            value: 'Jaunpur',
            child: Text(_isEnglishSelected ? 'Jaunpur' : 'जौनपुर'),
          ),
          DropdownMenuItem(
            value: 'Jhansi',
            child: Text(_isEnglishSelected ? 'Jhansi' : 'झांसी'),
          ),
          DropdownMenuItem(
            value: 'Kannauj',
            child: Text(_isEnglishSelected ? 'Kannauj' : 'कन्नौज'),
          ),
          DropdownMenuItem(
            value: 'Kanpur Dehat',
            child: Text(_isEnglishSelected ? 'Kanpur Dehat' : 'कानपुर देहात'),
          ),
          DropdownMenuItem(
            value: 'Kanpur Nagar',
            child: Text(_isEnglishSelected ? 'Kanpur Nagar' : 'कानपुर नगर'),
          ),
          DropdownMenuItem(
            value: 'Kasganj',
            child: Text(_isEnglishSelected ? 'Kasganj' : 'कासगंज'),
          ),
          DropdownMenuItem(
            value: 'Kaushambi',
            child: Text(_isEnglishSelected ? 'Kaushambi' : 'कौशांबी'),
          ),
          DropdownMenuItem(
            value: 'Kushinagar',
            child: Text(_isEnglishSelected ? 'Kushinagar' : 'कुशीनगर'),
          ),
          DropdownMenuItem(
            value: 'Lakhimpur Kheri',
            child:
                Text(_isEnglishSelected ? 'Lakhimpur Kheri' : 'लखीमपुर खीरी'),
          ),
          DropdownMenuItem(
            value: 'Lalitpur',
            child: Text(_isEnglishSelected ? 'Lalitpur' : 'ललितपुर'),
          ),
          DropdownMenuItem(
            value: 'Lucknow',
            child: Text(_isEnglishSelected ? 'Lucknow' : 'लखनऊ'),
          ),
          DropdownMenuItem(
            value: 'Maharajganj',
            child: Text(_isEnglishSelected ? 'Maharajganj' : 'महाराजगंज'),
          ),
          DropdownMenuItem(
            value: 'Mahoba',
            child: Text(_isEnglishSelected ? 'Mahoba' : 'महोबा'),
          ),
          DropdownMenuItem(
            value: 'Mainpuri',
            child: Text(_isEnglishSelected ? 'Mainpuri' : 'मैनपुरी'),
          ),
          DropdownMenuItem(
            value: 'Mathura',
            child: Text(_isEnglishSelected ? 'Mathura' : 'मथुरा'),
          ),
          DropdownMenuItem(
            value: 'Mau',
            child: Text(_isEnglishSelected ? 'Mau' : 'मऊ'),
          ),
          DropdownMenuItem(
            value: 'Meerut',
            child: Text(_isEnglishSelected ? 'Meerut' : 'मेरठ'),
          ),
          DropdownMenuItem(
            value: 'Mirzapur',
            child: Text(_isEnglishSelected ? 'Mirzapur' : 'मिर्जापुर।'),
          ),
          DropdownMenuItem(
            value: 'Moradabad',
            child: Text(_isEnglishSelected ? 'Moradabad' : 'मुरादाबाद'),
          ),
          DropdownMenuItem(
            value: 'Muzaffarnagar',
            child: Text(_isEnglishSelected ? 'Muzaffarnagar' : 'मुजफ्फरनगर'),
          ),
          DropdownMenuItem(
            value: 'Pilibhit',
            child: Text(_isEnglishSelected ? 'Pilibhit' : 'पीलीभीत'),
          ),
          DropdownMenuItem(
            value: 'Pratapgarh',
            child: Text(_isEnglishSelected ? 'Pratapgarh' : 'प्रतापगढ़'),
          ),
          DropdownMenuItem(
            value: 'Raebareli',
            child: Text(_isEnglishSelected ? 'Raebareli' : 'रायबरेली'),
          ),
          DropdownMenuItem(
            value: 'Rampur',
            child: Text(_isEnglishSelected ? 'Rampur' : 'रामपुर'),
          ),
          DropdownMenuItem(
            value: 'Saharanpur',
            child: Text(_isEnglishSelected ? 'Saharanpur' : 'सहारनपुर'),
          ),
          DropdownMenuItem(
            value: 'Sambhal',
            child: Text(_isEnglishSelected ? 'Sambhal' : 'सम्भल'),
          ),
          DropdownMenuItem(
            value: 'Sant Kabir Nagar',
            child:
                Text(_isEnglishSelected ? 'Sant Kabir Nagar' : 'संत कबीर नगर'),
          ),
          DropdownMenuItem(
            value: 'Shahjahanpur',
            child: Text(_isEnglishSelected ? 'Shahjahanpur' : 'शाहजहाँपुर'),
          ),
          DropdownMenuItem(
            value: 'Shamli [20]',
            child: Text(_isEnglishSelected ? 'Shamli [20]' : 'शामली [20]'),
          ),
          DropdownMenuItem(
            value: 'Shravasti',
            child: Text(_isEnglishSelected ? 'Shravasti' : 'श्रावस्ती'),
          ),
          DropdownMenuItem(
            value: 'Siddharthnagar',
            child: Text(_isEnglishSelected ? 'Siddharthnagar' : 'सिद्धार्थनगर'),
          ),
          DropdownMenuItem(
            value: 'Sitapur',
            child: Text(_isEnglishSelected ? 'Sitapur' : 'सीतापुर'),
          ),
          DropdownMenuItem(
            value: 'Sonbhadra',
            child: Text(_isEnglishSelected ? 'Sonbhadra' : 'सोनभद्र'),
          ),
          DropdownMenuItem(
            value: 'Sultanpur',
            child: Text(_isEnglishSelected ? 'Sultanpur' : 'सुल्तानपुर'),
          ),
          DropdownMenuItem(
            value: 'Unnao',
            child: Text(_isEnglishSelected ? 'Unnao' : 'उन्नाव।'),
          ),
          DropdownMenuItem(
            value: 'Varanasi',
            child: Text(_isEnglishSelected ? 'Varanasi' : 'वाराणसी'),
          ),
        ];
      case 'Uttarakhand':
        return [
          DropdownMenuItem(
            value: 'Almora',
            child: Text(_isEnglishSelected ? 'Almora' : 'अल्मोड़ा'),
          ),
          DropdownMenuItem(
            value: 'Bageshwar',
            child: Text(_isEnglishSelected ? 'Bageshwar' : 'बागेश्वर'),
          ),
          DropdownMenuItem(
            value: 'Chamoli',
            child: Text(_isEnglishSelected ? 'Chamoli' : 'चमोली।'),
          ),
          DropdownMenuItem(
            value: 'Champawat',
            child: Text(_isEnglishSelected ? 'Champawat' : 'चंपावत'),
          ),
          DropdownMenuItem(
            value: 'Dehradun',
            child: Text(_isEnglishSelected ? 'Dehradun' : 'देहरादून'),
          ),
          DropdownMenuItem(
            value: 'Haridwar',
            child: Text(_isEnglishSelected ? 'Haridwar' : 'हरिद्वार'),
          ),
          DropdownMenuItem(
            value: 'Nainital',
            child: Text(_isEnglishSelected ? 'Nainital' : 'नैनीताल'),
          ),
          DropdownMenuItem(
            value: 'Pauri Garhwal',
            child: Text(_isEnglishSelected ? 'Pauri Garhwal' : 'पौड़ी गढ़वाल'),
          ),
          DropdownMenuItem(
            value: 'Pithoragarh',
            child: Text(_isEnglishSelected ? 'Pithoragarh' : 'पिथौरागढ़'),
          ),
          DropdownMenuItem(
            value: 'Rudraprayag',
            child: Text(_isEnglishSelected ? 'Rudraprayag' : 'रुद्रप्रयाग'),
          ),
          DropdownMenuItem(
            value: 'Tehri Garhwal',
            child: Text(_isEnglishSelected ? 'Tehri Garhwal' : 'टिहरी गढ़वाल'),
          ),
          DropdownMenuItem(
            value: 'Udham Singh Nagar',
            child:
                Text(_isEnglishSelected ? 'Udham Singh Nagar' : 'उधमसिंह नगर'),
          ),
          DropdownMenuItem(
            value: 'Uttarkashi',
            child: Text(_isEnglishSelected ? 'Uttarkashi' : 'उत्तरकाशी'),
          ),
        ];
      case 'West Bengal':
        return [
          DropdownMenuItem(
            value: 'Alipurduar',
            child: Text(_isEnglishSelected ? 'Alipurduar' : 'अलीपुरद्वार'),
          ),
          DropdownMenuItem(
            value: 'Bankura',
            child: Text(_isEnglishSelected ? 'Bankura' : 'बांकुड़ा'),
          ),
          DropdownMenuItem(
            value: 'Paschim Bardhaman',
            child: Text(
                _isEnglishSelected ? 'Paschim Bardhaman' : 'पश्चिम बरधामन'),
          ),
          DropdownMenuItem(
            value: 'Purba Bardhaman',
            child:
                Text(_isEnglishSelected ? 'Purba Bardhaman' : 'पुरबा बारधामन'),
          ),
          DropdownMenuItem(
            value: 'Birbhum',
            child: Text(_isEnglishSelected ? 'Birbhum' : 'बीरभूम'),
          ),
          DropdownMenuItem(
            value: 'Cooch Behar',
            child: Text(_isEnglishSelected ? 'Cooch Behar' : 'कूच बिहार'),
          ),
          DropdownMenuItem(
            value: 'Dakshin Dinajpur',
            child: Text(
                _isEnglishSelected ? 'Dakshin Dinajpur' : 'दक्षिण दिनाजपुर'),
          ),
          DropdownMenuItem(
            value: 'Darjeeling',
            child: Text(_isEnglishSelected ? 'Darjeeling' : 'दार्जिलिंग'),
          ),
          DropdownMenuItem(
            value: 'Hooghly',
            child: Text(_isEnglishSelected ? 'Hooghly' : 'हुगली'),
          ),
          DropdownMenuItem(
            value: 'Howrah',
            child: Text(_isEnglishSelected ? 'Howrah' : 'हावड़ा'),
          ),
          DropdownMenuItem(
            value: 'Jalpaiguri',
            child: Text(_isEnglishSelected ? 'Jalpaiguri' : 'जलपाईगुड़ी'),
          ),
          DropdownMenuItem(
            value: 'Jhargram',
            child: Text(_isEnglishSelected ? 'Jhargram' : 'झारग्राम'),
          ),
          DropdownMenuItem(
            value: 'Kalimpong',
            child: Text(_isEnglishSelected ? 'Kalimpong' : 'कालिम्पोंग'),
          ),
          DropdownMenuItem(
            value: 'Kolkata',
            child: Text(_isEnglishSelected ? 'Kolkata' : 'कोलकाता'),
          ),
          DropdownMenuItem(
            value: 'Maldah',
            child: Text(_isEnglishSelected ? 'Maldah' : 'मालदाह'),
          ),
          DropdownMenuItem(
            value: 'Murshidabad',
            child: Text(_isEnglishSelected ? 'Murshidabad' : 'मुर्शिदाबाद'),
          ),
          DropdownMenuItem(
            value: 'Nadia',
            child: Text(_isEnglishSelected ? 'Nadia' : 'नादिया'),
          ),
          DropdownMenuItem(
            value: 'North 24 Parganas',
            child: Text(
                _isEnglishSelected ? 'North 24 Parganas' : 'उत्तर 24 परगना'),
          ),
          DropdownMenuItem(
            value: 'Paschim Medinipur',
            child: Text(
                _isEnglishSelected ? 'Paschim Medinipur' : 'पशिम मेदिनीपुर'),
          ),
          DropdownMenuItem(
            value: 'Purba Medinipur',
            child: Text(
                _isEnglishSelected ? 'Purba Medinipur' : 'पुरबा मेदिनीपुर'),
          ),
          DropdownMenuItem(
            value: 'Purulia',
            child: Text(_isEnglishSelected ? 'Purulia' : 'पुरुलिया'),
          ),
          DropdownMenuItem(
            value: 'South 24 Parganas',
            child: Text(
                _isEnglishSelected ? 'South 24 Parganas' : 'दक्षिण 24 परगना'),
          ),
          DropdownMenuItem(
            value: 'Uttar Dinajpur',
            child:
                Text(_isEnglishSelected ? 'Uttar Dinajpur' : 'उत्तर दिनाजपुर'),
          ),
        ];
      case 'Andaman and Nicobar':
        return [
          DropdownMenuItem(
            value: 'Nicobar',
            child: Text(_isEnglishSelected ? 'Nicobar' : 'निकोबार'),
          ),
          DropdownMenuItem(
            value: 'North and Middle Andaman',
            child: Text(_isEnglishSelected
                ? 'North and Middle Andaman'
                : 'उत्तर और मध्य अंडमान'),
          ),
          DropdownMenuItem(
            value: 'South Andaman',
            child: Text(_isEnglishSelected ? 'South Andaman' : 'दक्षिण अंडमान'),
          ),
        ];
      case 'Chandigarh':
        return [
          DropdownMenuItem(
            value: 'Chandigarh',
            child: Text(_isEnglishSelected ? 'Chandigarh' : 'चंडीगढ़'),
          ),
        ];
      case 'Dadra and Nagar Haveli and Daman and Diu':
        return [
          DropdownMenuItem(
            value: 'Daman',
            child: Text(_isEnglishSelected ? 'Daman' : 'दमन'),
          ),
          DropdownMenuItem(
            value: 'Diu',
            child: Text(_isEnglishSelected ? 'Diu' : 'दीव'),
          ),
          DropdownMenuItem(
            value: 'Dadra and Nagar Haveli',
            child: Text(_isEnglishSelected
                ? 'Dadra and Nagar Haveli'
                : 'दादरा और नगर हाली'),
          ),
        ];
      case 'Jammu and Kashmir ':
        return [
          DropdownMenuItem(
            value: 'Anantnag',
            child: Text(_isEnglishSelected ? 'Anantnag' : 'अनंतनाग'),
          ),
          DropdownMenuItem(
            value: 'Bandipora',
            child: Text(_isEnglishSelected ? 'Bandipora' : 'बांदीपोरा'),
          ),
          DropdownMenuItem(
            value: 'Baramulla',
            child: Text(_isEnglishSelected ? 'Baramulla' : 'बारामूला'),
          ),
          DropdownMenuItem(
            value: 'Badgam',
            child: Text(_isEnglishSelected ? 'Badgam' : 'बडगाम'),
          ),
          DropdownMenuItem(
            value: 'Doda',
            child: Text(_isEnglishSelected ? 'Doda' : 'डोडा'),
          ),
          DropdownMenuItem(
            value: 'Ganderbal',
            child: Text(_isEnglishSelected ? 'Ganderbal' : 'गांदरबल'),
          ),
          DropdownMenuItem(
            value: 'Jammu',
            child: Text(_isEnglishSelected ? 'Jammu' : 'जम्मू'),
          ),
          DropdownMenuItem(
            value: 'Kathua',
            child: Text(_isEnglishSelected ? 'Kathua' : 'कठुआ'),
          ),
          DropdownMenuItem(
            value: 'Kishtwar',
            child: Text(_isEnglishSelected ? 'Kishtwar' : 'किश्तवाड़'),
          ),
          DropdownMenuItem(
            value: 'Kulgam',
            child: Text(_isEnglishSelected ? 'Kulgam' : 'कुलगाम'),
          ),
          DropdownMenuItem(
            value: 'Kupwara',
            child: Text(_isEnglishSelected ? 'Kupwara' : 'कुपवाड़ा'),
          ),
          DropdownMenuItem(
            value: 'Poonch',
            child: Text(_isEnglishSelected ? 'Poonch' : 'पुंछ'),
          ),
          DropdownMenuItem(
            value: 'Pulwama',
            child: Text(_isEnglishSelected ? 'Pulwama' : 'पुलवामा'),
          ),
          DropdownMenuItem(
            value: 'Rajouri',
            child: Text(_isEnglishSelected ? 'Rajouri' : 'राजौरी'),
          ),
          DropdownMenuItem(
            value: 'Ramban',
            child: Text(_isEnglishSelected ? 'Ramban' : 'रामबन'),
          ),
          DropdownMenuItem(
            value: 'Reasi',
            child: Text(_isEnglishSelected ? 'Reasi' : 'रियासी'),
          ),
          DropdownMenuItem(
            value: 'Samba',
            child: Text(_isEnglishSelected ? 'Samba' : 'सांबा'),
          ),
          DropdownMenuItem(
            value: 'Shopian',
            child: Text(_isEnglishSelected ? 'Shopian' : 'शोपियां'),
          ),
          DropdownMenuItem(
            value: 'Srinagar',
            child: Text(_isEnglishSelected ? 'Srinagar' : 'श्रीनगर'),
          ),
          DropdownMenuItem(
            value: 'Udhampur',
            child: Text(_isEnglishSelected ? 'Udhampur' : 'ऊधमपुर'),
          ),
        ];
      case 'Delhi':
        return [
          DropdownMenuItem(
            value: 'Central Delhi',
            child: Text(_isEnglishSelected ? 'Central Delhi' : 'मध्य दिल्ली'),
          ),
          DropdownMenuItem(
            value: 'East Delhi',
            child: Text(_isEnglishSelected ? 'East Delhi' : 'पूर्वी दिल्ली'),
          ),
          DropdownMenuItem(
            value: 'New Delhi',
            child: Text(_isEnglishSelected ? 'New Delhi' : 'नई दिल्ली'),
          ),
          DropdownMenuItem(
            value: 'North Delhi',
            child: Text(_isEnglishSelected ? 'North Delhi' : 'उत्तरी दिल्ली'),
          ),
          DropdownMenuItem(
            value: 'North East Delhi',
            child: Text(_isEnglishSelected
                ? 'North East Delhi'
                : 'उत्तर पूर्वी दिल्ली'),
          ),
          DropdownMenuItem(
            value: 'North West Delhi',
            child: Text(_isEnglishSelected
                ? 'North West Delhi'
                : 'उत्तर पश्चिमी दिल्ली'),
          ),
          DropdownMenuItem(
            value: 'Shahdara',
            child: Text(_isEnglishSelected ? 'Shahdara' : 'शाहदरा'),
          ),
          DropdownMenuItem(
            value: 'South Delhi',
            child: Text(_isEnglishSelected ? 'South Delhi' : 'दक्षिणी दिल्ली'),
          ),
          DropdownMenuItem(
            value: 'South East Delhi',
            child: Text(_isEnglishSelected
                ? 'South East Delhi'
                : 'दक्षिण पूर्वी दिल्ली'),
          ),
          DropdownMenuItem(
            value: 'South West Delhi',
            child: Text(_isEnglishSelected
                ? 'South West Delhi'
                : 'दक्षिण पश्चिम दिल्ली'),
          ),
          DropdownMenuItem(
            value: 'West Delhi',
            child: Text(_isEnglishSelected ? 'West Delhi' : 'पश्चिमी दिल्ली'),
          ),
        ];
      case 'Puducherry':
        return [
          DropdownMenuItem(
            value: 'Karaikal',
            child: Text(_isEnglishSelected ? 'Karaikal' : 'कराईकल'),
          ),
          DropdownMenuItem(
            value: 'Mahé',
            child: Text(_isEnglishSelected ? 'Mahé' : 'माहे'),
          ),
          DropdownMenuItem(
            value: 'Pondicherry',
            child: Text(_isEnglishSelected ? 'Pondicherry' : 'पांडिचेरी'),
          ),
          DropdownMenuItem(
            value: 'Yanam',
            child: Text(_isEnglishSelected ? 'Yanam' : 'यानम'),
          ),
        ];
      case 'Ladakh':
        return [
          DropdownMenuItem(
            value: 'Kargil',
            child: Text(_isEnglishSelected ? 'Kargil' : 'कारगिल'),
          ),
          DropdownMenuItem(
            value: 'Leh',
            child: Text(_isEnglishSelected ? 'Leh' : 'लेह'),
          ),
        ];
      case 'Lakshadweep':
        return [
          DropdownMenuItem(
            value: 'Lakshadweep',
            child: Text(_isEnglishSelected ? 'Lakshadweep' : 'लक्षद्वीप'),
          ),
        ];
      default:
        return [];
    }
  }
}
