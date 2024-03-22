import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'utils/globals.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0098DA),
        // Custom color for app bar
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Functionality for back button
          },
        ),
        title: Text(
          _isEnglishSelected ? 'Support' : 'सहायता', // Custom title text
          style: TextStyle(
            color: Colors.white, // Custom color for title text
            fontSize: 25.0, // Custom font size for title text
            fontWeight: FontWeight.w600, // Custom font weight for title text
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final phoneNumber = "tel:+919536870029";
                  if (await canLaunch(phoneNumber)) {
                    await launch(phoneNumber);
                  } else {
                    throw 'Could not launch $phoneNumber';
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.75,
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      color: Color(0xFF0098DA),
                      width: 3,
                    ),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call_outlined,
                        size: MediaQuery.of(context).size.width / 6,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width / 60),
                      Text(
                        _isEnglishSelected ? "Call us" : "फ़ोन करें",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  String url =
                      "whatsapp://send?phone=919536870029&text=${Uri.encodeFull("Hey!")}";

                  launch(url);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.75,
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      color: Color(0xFF0098DA),
                      width: 3,
                    ),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mode_edit_outlined,
                        size: MediaQuery.of(context).size.width / 6,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width / 60),
                      Text(
                        _isEnglishSelected ? "Write to us" : "हमें लिखें",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.manual,
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      _isEnglishSelected
                                          ? 'Request a call'
                                          : 'कॉल का अनुरोध करें।',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        decorationThickness: 0,
                                        //decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Center(
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Material(
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              child: Text(
                                                _isEnglishSelected
                                                    ? "Name"
                                                    : "नाम",
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const SizedBox(width: 10.0),
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.name,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .singleLineFormatter,
                                                      ],
                                                      controller:
                                                          _nameController,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText:
                                                            'Enter your Name',
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2.0),
                                            Container(
                                              height: 1.0,
                                              color: const Color.fromARGB(
                                                  255, 0, 153, 218),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Material(
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _isEnglishSelected
                                                  ? "Phone No"
                                                  : "फोन नंबर",
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Image.asset(
                                                        'assets/flag.png',
                                                        width: 25.0,
                                                        height: 25.0,
                                                      ),
                                                      const SizedBox(
                                                          width: 5.0),
                                                      Text(
                                                        _phoneCode,
                                                        style: const TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: 5.0),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 10.0),
                                                Expanded(
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                      LengthLimitingTextInputFormatter(
                                                          10),
                                                    ],
                                                    controller:
                                                        _phoneController,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          'Enter your phone number',
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8.0),
                                            Container(
                                              height: 1.0,
                                              color: const Color.fromARGB(
                                                  255, 0, 153, 218),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      //Request a call
                                    },
                                    child: Container(
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: const Color(0xFF0098DA),
                                      ),
                                      child: Center(
                                        child: Text(
                                          _isEnglishSelected
                                              ? 'Submit'
                                              : 'जमा करें',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            decorationThickness: 0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.75,
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      color: Color(0xFF0098DA),
                      width: 3,
                    ),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call_outlined,
                        size: MediaQuery.of(context).size.width / 6,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width / 60),
                      Text(
                        _isEnglishSelected
                            ? "Request a call"
                            : "कॉल का अनुरोध करें",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 1.95,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
