import 'package:flutter/material.dart';
import 'globals.dart';

class User_application extends StatefulWidget {
  @override
  _User_applicationState createState() => _User_applicationState();
}

class _User_applicationState extends State<User_application> {
  bool _isEnglishSelected = isEnglishSelected;

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
          _isEnglishSelected
              ? 'My Applications'
              : 'में ने इंटरेस्ट भेजा', // Custom title text
          style: TextStyle(
            color: Colors.white, // Custom color for title text
            fontSize: 25.0, // Custom font size for title text
            fontWeight: FontWeight.w600, // Custom font weight for title text
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JobApplicationTile(
              isEnglishSelected: _isEnglishSelected,
              job: 'Job Title',
              img: 'assets/category/cook.png',
              location: 'Hyderabad, Telangana',
              salary: '8500 Per Month',
              sector: 'IT',
            ),
            JobApplicationTile(
              isEnglishSelected: _isEnglishSelected,
              job: 'Job Title',
              img: 'assets/category/cook.png',
              location: 'Hyderabad, Telangana',
              salary: '8500 Per Month',
              sector: 'IT',
            ),
            JobApplicationTile(
              isEnglishSelected: _isEnglishSelected,
              job: 'Job Title',
              img: 'assets/category/cook.png',
              location: 'Hyderabad, Telangana',
              salary: '8500 Per Month',
              sector: 'IT',
            ),
            JobApplicationTile(
              isEnglishSelected: _isEnglishSelected,
              job: 'Job Title',
              img: 'assets/category/cook.png',
              location: 'Hyderabad, Telangana',
              salary: '8500 Per Month',
              sector: 'IT',
            ),
          ],
        ),
      ),
    );
  }
}

class JobApplicationTile extends StatelessWidget {
  const JobApplicationTile({
    Key? key,
    required bool isEnglishSelected,
    required String job,
    required String salary,
    required String location,
    required String img,
    required String sector,
  })  : _isEnglishSelected = isEnglishSelected,
        _job = job,
        _salary = salary,
        _location = location,
        _img = img,
        _sector = sector,
        super(key: key);

  final bool _isEnglishSelected;
  final String _job;
  final String _salary;
  final String _location;
  final String _img;
  final String _sector;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.25,
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                //width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width),
                                  border: Border.all(
                                    color: Color(0xFF0098DA),
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    '$_img',
                                    color: Color(0xFF0098DA),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              //mainAxisAlignment:MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '$_job',
                                    style: TextStyle(
                                        color: Color(0xFF0098DA),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 239, 83, 122),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      '$_salary',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Color(0xFF0098DA),
                                    ),
                                    OverflowBox(
                                      maxWidth: double.infinity,
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        '$_location',
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                            color: Color(0xFF0098DA),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.only(top: 8, right: 8),
                              child: Text(
                                '$_sector',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                            flex: 1,
                          ),
                          Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              21,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(0, 152, 218,
                                            1.000), // set fill color
                                        borderRadius: BorderRadius.circular(
                                            30), // set border radius to create capsule shape
                                        border: Border.all(
                                          color: Color.fromRGBO(0, 152, 218,
                                              1.000), // set border color
                                          width: 3,
                                        ),
                                      ),
                                      padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
                                      child: Center(
                                        child: Text(
                                          _isEnglishSelected
                                              ? "Get Contact"
                                              : "फोन नंबर देखे",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                21,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              30), // set border radius to create capsule shape
                                          border: Border.all(
                                            color: Color.fromRGBO(0, 152, 218,
                                                1.000), // set border color
                                            width: 3,
                                          ),
                                        ),
                                        padding: EdgeInsets.all(2),
                                        child: Center(
                                          child: Text(
                                            _isEnglishSelected
                                                ? "Generate OTP"
                                                : "ओटीपी जनरेट करें",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.8),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(125),
                      border: Border.all(
                        color: Color(0xFF0098DA),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        _img,
                        color: Color(0xFF0098DA),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '$_job',
                        style: TextStyle(
                            color: Color(0xFF0098DA),
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 239, 83, 122),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          '$_salary',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,

                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xFF0098DA),
                        ),
                        Text(
                          '$_location',
                          style: TextStyle(
                              color: Color(0xFF0098DA),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.25,
                              height: MediaQuery.of(context).size.height / 1.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Material(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Container(
                                            //width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width),
                                              border: Border.all(
                                                color: Color(0xFF0098DA),
                                                width: 2,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Image.asset(
                                                '$_img',
                                                color: Color(0xFF0098DA),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          //mainAxisAlignment:MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                '$_job',
                                                style: TextStyle(
                                                    color: Color(0xFF0098DA),
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 239, 83, 122),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                                child: Text(
                                                  '$_salary',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Color(0xFF0098DA),
                                                ),
                                                Text(
                                                  '$_location',
                                                  style: TextStyle(
                                                      color: Color(0xFF0098DA),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 8, right: 8),
                                          child: Text(
                                            '$_sector',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          flex: 4,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      21,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        0,
                                                        152,
                                                        218,
                                                        1.000), // set fill color
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30), // set border radius to create capsule shape
                                                    border: Border.all(
                                                      color: Color.fromRGBO(
                                                          0,
                                                          152,
                                                          218,
                                                          1.000), // set border color
                                                      width: 3,
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.fromLTRB(
                                                      4, 8, 4, 8),
                                                  child: Center(
                                                    child: Text(
                                                      _isEnglishSelected
                                                          ? "Get Contact"
                                                          : "फोन नंबर देखे",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 21,
                                              ),
                                              GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            21,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30), // set border radius to create capsule shape
                                                      border: Border.all(
                                                        color: Color.fromRGBO(
                                                            0,
                                                            152,
                                                            218,
                                                            1.000), // set border color
                                                        width: 3,
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.all(2),
                                                    child: Center(
                                                      child: Text(
                                                        _isEnglishSelected
                                                            ? "Generate OTP"
                                                            : "ओटीपी जनरेट करें",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 21,
                    decoration: BoxDecoration(
                      color:
                          Color.fromRGBO(0, 152, 218, 1.000), // set fill color
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
                        _isEnglishSelected ? "View" : "देखे",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
