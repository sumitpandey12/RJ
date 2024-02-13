import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:rotijugaad/payment_history.dart';

class HireSuccessPage extends StatefulWidget {
  @override
  _HireSuccessPageState createState() => _HireSuccessPageState();
}

class _HireSuccessPageState extends State<HireSuccessPage> {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 3));

  @override
  void initState() {
    super.initState();
    // Start the confetti animation when the page is opened
    _confettiController.play();
  }

  @override
  void dispose() {
    // Dispose the confetti controller when the page is disposed
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              blastDirection: -90,
              emissionFrequency: 0,
              numberOfParticles: 200,
              maxBlastForce: 20,
              minBlastForce: 10,
              gravity: 0.5,
              colors: [
                Colors.blue,
                Colors.orange,
                Colors.red,
                Colors.yellow,
                Colors.green
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 120,
              ),
            ),
            Text(
              'Employee was hired successfully',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentHistoryPage(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF0098DA),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Center(
                  child: Text(
                    'View hired Candidates',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
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
