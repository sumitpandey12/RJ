import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DevInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developer Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'WEBMINIX',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Whether you're looking to launch a new product, expand into new markets, or simply streamline your operations, Webminix has the expertise and resources to help you succeed. From idea validation and development to app and web development, post-launch marketing and maintenance support, we offer a wide range of services designed to help businesses grow and thrive. Our marketing campaigns are designed to help you acquire and retain customers, increase brand awareness, and drive sales. And with our maintenance support, you can rest assured that your product will continue to function at its best long after it's launched.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.225),
              child: GestureDetector(
                onTap: () => launch('https://www.webminix.com'),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  child: Text(
                    'Visit Us',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.225),
              child: GestureDetector(
                onTap: () async {
                  final phoneNumber = "tel:+919557737233";
                  if (await canLaunch(phoneNumber)) {
                    await launch(phoneNumber);
                  } else {
                    throw 'Could not launch $phoneNumber';
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Contact Us',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
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
  }
}
