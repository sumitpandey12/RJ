import 'package:flutter/material.dart';
import 'package:rotijugaad/transaction_sucess.dart';
import 'package:rotijugaad/user_contact_history.dart';
import 'globals.dart';

class UserSubscription extends StatefulWidget {
  @override
  _UserSubscriptionState createState() => _UserSubscriptionState();
}

class _UserSubscriptionState extends State<UserSubscription> {
  final bool _isEnglishSelected = isEnglishSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0098DA),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          _isEnglishSelected ? 'Subscription' : 'सदस्यता',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      _isEnglishSelected
                          ? 'You Can buy multiple subscriptions that will add credits and validity.'
                          : 'आप कई सब्सक्रिप्शन खरीद सकते हैं जो क्रेडिट और वैधता जोड़ देगा।',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 2),
                              child: Column(
                                children: [
                                  Center(
                                      child: Text(
                                    "Basic\nPlan",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 24),
                                  )),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    "-Unlock 10 contact no Views\n\n-Unlock Send Interest of 20 Profiles.\n\n-Unlock Send Interest of 20 Profiles.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TransactionSuccessPage()),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF0098DA),
                                          borderRadius:
                                              BorderRadius.circular(32.0),
                                        ),
                                        child: Center(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'Buy Again',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Valid for 30 Days',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF0098DA),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 24),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: Color(0xFFEF537A),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "199₹",
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            "99 ₹",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Text(
                                "Active Plan",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                          child: Column(
                            children: [
                              Center(
                                  child: Text(
                                "Advance\nPlan",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24),
                              )),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                "-Unlock 20 contact no Views\n\n-Unlock Send Interest of 40 Profiles.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0098DA),
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Buy',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Valid for 180 Days',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF0098DA),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 24),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Color(0xFFEF537A),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "499₹",
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        "249 ₹",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                          child: Column(
                            children: [
                              Center(
                                  child: Text(
                                "Premium Plan",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24),
                              )),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                "-Unlock 40 contact no Views\n\n-Unlock Send Interest of 80 Profiles.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0098DA),
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Buy',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Valid for 365 Days',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF0098DA),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 24),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Color(0xFFEF537A),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "999₹",
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        "499 ₹",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Your Basic Plan is Valid till 25 April 2023",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      "You Have",
                      style: TextStyle(color: Colors.blue, fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: '02',
                                        style: TextStyle(
                                            fontSize: 30.0, color: Colors.blue),
                                      ),
                                      TextSpan(
                                        text: '/10',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Contact Credits",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 5),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserContact()),
                                    );
                                  },
                                  child: Text(
                                    'View History',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: '02',
                                        style: TextStyle(
                                            fontSize: 30.0, color: Colors.blue),
                                      ),
                                      TextSpan(
                                        text: '/10',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Interest Credits",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 5),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'View History',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
