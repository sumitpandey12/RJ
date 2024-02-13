import 'package:flutter/material.dart';
import 'package:rotijugaad/user_update_personal_info.dart';

class EmpProfilePage extends StatefulWidget {
  @override
  _EmpProfilePageState createState() => _EmpProfilePageState();
}

class _EmpProfilePageState extends State<EmpProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 200.0,
            decoration: BoxDecoration(),
            child: ClipRRect(
              child: Image.asset(
                'assets/img.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5.0),

          // Tab buttons

          // Tab views
          Expanded(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(5),
                        },
                        children: [
                          _buildTableRow('Name', 'John Doe'),
                          _buildTableRow('Organization', 'ABC Pvt. Ltd.'),
                          _buildTableRow('City', 'Mumbai'),
                          _buildTableRow('State', 'Maharashtra'),
                          _buildTableRow('Contact No.', '1234567890'),
                          _buildTableRow('Email Id', 'john.doe@example.com'),
                          _buildTableRow('Organization Type', 'Hardware'),
                          _buildTableRow('Address',
                              '123, Main Street, Near ABC Circle Mumbai, Maharashtra India'),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 20,
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          //color: Colors.blue,
                          //size: 50,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Container(
                                  width: double.maxFinite,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Update Email',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle:
                                              TextStyle(color: Colors.blue),
                                          hintText: 'Enter new email',
                                          border: UnderlineInputBorder(),
                                        ),
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            // Perform the update email action here
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 20),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 20,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              'Update',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
                Spacer()
              ],
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
