import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:rotijugaad/screens/SignUp/signup_employer.dart';

class OTP {
  static String generateRandomNumber() {
    final random = Random();
    final randomNumber = 1000 + random.nextInt(9999 - 1000 + 1);
    return randomNumber.toString();
  }

  static Future<String> sendSMS(String phoneNumber) async {
    final headers = {
      'accept': 'text/plain',
    };

    String otp = OTP.generateRandomNumber();

    final params = {
      'SenderId': 'RJUGAD',
      'Message':
          'Your OTP to access RotiJugaad is $otp. It will be valid for 10 minutes. Please don\'t share with others.',
      'MobileNumbers': phoneNumber,
      'ApiKey': 'OFm4EM9yOt8oKeo4PT4DNbub+5/K+jaXZsgcGjo7+po=',
      'ClientId': '658cc1dc-4989-44c8-be6a-1b56610f0b9f',
    };

    final url = Uri.https('api.zapsms.co.in', '/api/v2/SendSMS', params);

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Request successful, you can handle the response here
      print('SMS sent successfully');
    } else {
      // Request failed, handle the error
      print('Failed to send SMS. Status code: ${response.statusCode}');
    }

    return otp;
  }
}
