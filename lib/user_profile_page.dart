import 'package:flutter/material.dart';
import 'package:rotijugaad/user_update_personal_info.dart';
import 'package:rotijugaad/user_update_xp.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
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
            height: 125.0,
            width: 125.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(
                color: Colors.blue,
                width: 2.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.network(
                'https://picsum.photos/200',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'Your Name',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          // Tab buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40.0,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.white,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.all(6),
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(
                    text: 'About',
                  ),
                  Tab(
                    text: 'Experience',
                  ),
                  Tab(
                    text: 'Preference',
                  ),
                ],
              ),
            ),
          ),

          // Tab views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
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
                              0: FlexColumnWidth(2),
                              1: FlexColumnWidth(4),
                            },
                            children: [
                              _buildTableRow('Age', '23'),
                              _buildTableRow('Gender', 'Male'),
                              _buildTableRow('Location', 'Mumbai'),
                              _buildTableRow('Preferred Location', 'Pune'),
                              _buildTableRow(
                                  'Qualification', 'Bachelor of Engineering'),
                              _buildTableRow('Expected Salary', '50,000/month'),
                              _buildTableRow('Preferred Shift', 'Day'),
                              _buildTableRow('Phone No.', '1234567890'),
                              _buildTableRow('Aadhar No.', '1234 5678 9012'),
                              _buildTableRow('Email', 'john.doe@example.com'),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserPersonalInfoUpdate(),
                                  ),
                                );
                              },
                            ))
                      ],
                    ),
                    Spacer()
                  ],
                ),
                Container(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Column(
                            children: [
                              Column(children: [
                                ExpInfoTile(
                                  organization: 'My Organization',
                                  role: 'My Role',
                                  duration: '2 years',
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          right: 30,
                          bottom: 40,
                          child: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.blue,
                              size: 50,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserUpdateExperience(),
                                ),
                              );
                            },
                          ))
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      JobPreferenceTile(
                        categoryImage: 'assets/category/cook.png',
                        categoryName: 'Cook/Chef',
                        number: 1,
                      ),
                      JobPreferenceTile(
                        categoryImage: 'assets/category/carpenter.png',
                        categoryName: 'Carpenter',
                        number: 2,
                      ),
                      JobPreferenceTile(
                        categoryImage: 'assets/category/driver.png',
                        categoryName: 'Driver',
                        number: 3,
                      ),

                      // Add two more similar containers here
                    ],
                  ),
                ),
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

class ExpInfoTile extends StatelessWidget {
  final String organization;
  final String role;
  final String duration;

  const ExpInfoTile({
    Key? key,
    required this.organization,
    required this.role,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                organization,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                role,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                duration,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class JobPreferenceTile extends StatelessWidget {
  final String categoryImage;
  final String categoryName;
  final int number;

  const JobPreferenceTile({
    Key? key,
    required this.categoryImage,
    required this.categoryName,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            width: 25.0,
            height: 25.0,
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 15.0),
          Image(
            image: AssetImage(categoryImage),
            width: 35.0,
            height: 35.0,
          ),
          SizedBox(width: 15.0),
          Text(
            categoryName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Spacer(),
          Icon(Icons.edit),
        ],
      ),
    );
  }
}
