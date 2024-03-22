import 'package:flutter/material.dart';
import 'utils/globals.dart';

class UserNotif extends StatefulWidget {
  @override
  _UserNotifState createState() => _UserNotifState();
}

class _UserNotifState extends State<UserNotif> {
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
          _isEnglishSelected ? 'Notification' : 'अधिसूचना', // Custom title text
          style: TextStyle(
            color: Colors.white, // Custom color for title text
            fontSize: 25.0, // Custom font size for title text
            fontWeight: FontWeight.w600, // Custom font weight for title text
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: notification_bubble(
                text: "Rockst",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class notification_bubble extends StatelessWidget {
  final String text; // Define a variable to hold the text

  notification_bubble({required this.text, Key? key})
      : super(key: key); // Constructor with required text parameter

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text, // Use the text parameter here
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF272727),
        ),
      ),
    );
  }
}
