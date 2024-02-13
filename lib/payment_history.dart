import 'package:flutter/material.dart';
import 'globals.dart';

class PaymentHistoryPage extends StatelessWidget {
  PaymentHistoryPage({Key? key}) : super(key: key);

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
          isEnglishSelected
              ? 'Payment history'
              : 'पेमेंट इतिहास', // Custom title text
          style: TextStyle(
            color: Colors.white, // Custom color for title text
            fontSize: 25.0, // Custom font size for title text
            fontWeight: FontWeight.w600, // Custom font weight for title text
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  child: Center(
                      child: Text(
                    isEnglishSelected ? "Order ID" : "भुगतान सांख्य",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  )),
                  flex: 2,
                ),
                Expanded(
                  child: Center(
                      child: Text(isEnglishSelected ? "Date" : "तारीख",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600))),
                  flex: 3,
                ),
                Expanded(
                  child: Center(
                      child: Text(isEnglishSelected ? "Amount" : "राशि",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600))),
                  flex: 2,
                ),
                Expanded(
                  child: Center(
                      child: Text(isEnglishSelected ? "Invoice" : "बिल",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600))),
                  flex: 3,
                ),
              ],
            ),
            PaymentHistoryTile(
              orderId: "1234",
              date: "March 24, 2023",
              amount: "\$9.99",
            ),
            PaymentHistoryTile(
              orderId: "1234",
              date: "March 24, 2023",
              amount: "\$9.99",
            )
          ],
        ),
      ),
    );
  }
}

class PaymentHistoryTile extends StatelessWidget {
  final String orderId;
  final String date;
  final String amount;

  const PaymentHistoryTile({
    Key? key,
    required this.orderId,
    required this.date,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              orderId,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
          flex: 2,
        ),
        Expanded(
          child: Center(
            child: Text(
              date,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
          flex: 3,
        ),
        Expanded(
          child: Center(
            child: Text(
              amount,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
          flex: 2,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.blue,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                child: Center(
                  child: Text(
                    isEnglishSelected ? "Download" : "डाउनलोड",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          flex: 3,
        ),
      ],
    );
  }
}
