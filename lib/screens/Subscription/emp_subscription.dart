import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rotijugaad/APIs/employer.dart';
import 'package:rotijugaad/models/EmployerModel.dart';
import 'package:rotijugaad/transaction_sucess.dart';
import 'package:rotijugaad/user_contact_history.dart';
import '../../models/employerSubscriptionModel.dart';
import '../../utils/globals.dart';

class EmpSubscription extends StatefulWidget {
  final EmployerModel? employer;

  const EmpSubscription({super.key, this.employer});

  @override
  _EmpSubscriptionState createState() => _EmpSubscriptionState();
}

class _EmpSubscriptionState extends State<EmpSubscription> {
  final bool _isEnglishSelected = isEnglishSelected;
  List<EmployerSubscriptionModel>? listOfSubscription;
  bool isLoading = true;
  String? validity;

  @override
  void initState() {
    // TODO: implement initState
    log("Subscription Init Loaded");
    log(widget.employer == null ? "Employee Null" : "Employee Not Null");
    super.initState();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    validity = formatter.format(now);
    getData();
  }

  getData() async {
    listOfSubscription = await EmployerService.employerSubscription();
    setState(() {
      isLoading = false;
    });
    log("${listOfSubscription?.length.toString()}");
  }

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
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : listOfSubscription?.length == null
                      ? Center(
                          child: Text("No Plan Available Yet!"),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 5),
                          child: IntrinsicHeight(
                            child: Row(
                              children: listOfSubscription!
                                  .map((e) => PlanWidget(
                                      model: e,
                                      isActive: widget.employer?.activePack ==
                                              e.planName
                                          ? true
                                          : false))
                                  .toList(),
                            ),
                          ),
                        ),
              const SizedBox(
                height: 15,
              ),
              widget.employer != null
                  ? YourPlanWidget(
                      employer: widget.employer!,
                      validity: validity ?? '',
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class YourPlanWidget extends StatelessWidget {
  final EmployerModel employer;
  final String validity;
  const YourPlanWidget(
      {super.key, required this.employer, required this.validity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Your Basic Plan is Valid till ${validity}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.05,
          padding: EdgeInsets.symmetric(vertical: 10),
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
                style: TextStyle(color: Colors.blue, fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                                  text: '${employer.contactCredits}',
                                  style: TextStyle(
                                      fontSize: 25.0, color: Colors.blue),
                                ),
                                TextSpan(
                                  text: '/${employer.totalContactCredits}',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Contact Credits",
                            style: TextStyle(fontSize: 14),
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
                                fontSize: 12.0,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      )),
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
                                  text: '${employer.interestCredits}',
                                  style: TextStyle(
                                      fontSize: 25.0, color: Colors.blue),
                                ),
                                TextSpan(
                                  text: '/${employer.totalInterestCredits}',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Interest Credits",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'View History',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      )),
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
                                  text: '${employer.jobPostCredits}',
                                  style: TextStyle(
                                      fontSize: 25.0, color: Colors.blue),
                                ),
                                TextSpan(
                                  text: '/${employer.totalJobPostCredits}',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Job Post Credits",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'View History',
                              style: TextStyle(
                                fontSize: 12.0,
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
              ),
            ],
          ),
        )
      ],
    );
  }
}

class PlanWidget extends StatelessWidget {
  final EmployerSubscriptionModel model;
  final bool isActive;
  const PlanWidget({super.key, required this.model, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
            child: Column(
              children: [
                Center(
                    child: Text(
                  "${model.planName}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24),
                )),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "${model.text}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransactionSuccessPage()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF0098DA),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          //Buy API Call
                        },
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
                ),
                Center(
                  child: Text(
                    'Valid for ${model.validityInDays} Days',
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
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Color(0xFFEF537A),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "₹${model.price}",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "₹${model.discountedPrice}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          isActive
              ? Positioned(
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
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
