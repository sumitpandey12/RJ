import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Responsive {
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;
}

class Utils {
  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static List<DropdownMenuItem<String>>? jobProfileDropdownList(
      bool _isEnglishSelected) {
    return [
      DropdownMenuItem(
        value: 'Security Guard',
        child: Text(_isEnglishSelected ? 'Security Guard' : 'सुरक्षा कर्मी'),
      ),
      DropdownMenuItem(
        value: 'Helper',
        child: Text(_isEnglishSelected ? 'Helper' : 'सहायक'),
      ),
      DropdownMenuItem(
        value: 'Salesman',
        child: Text(_isEnglishSelected ? 'Salesman' : 'विक्रेता'),
      ),
      DropdownMenuItem(
        value: 'Delivery Boy',
        child: Text(_isEnglishSelected ? 'Delivery Boy' : 'वितरण लड़का'),
      ),
      DropdownMenuItem(
        value: 'Driver',
        child: Text(_isEnglishSelected ? 'Driver' : 'चालक'),
      ),
      DropdownMenuItem(
        value: 'Manager',
        child: Text(_isEnglishSelected ? 'Manager' : 'प्रबंधक'),
      ),
      DropdownMenuItem(
        value: 'Cleaning Expert',
        child: Text(_isEnglishSelected ? 'Cleaning Expert' : 'सफाईसहायक'),
      ),
      DropdownMenuItem(
        value: 'Accountant',
        child: Text(_isEnglishSelected ? 'Accountant' : 'मुनीम'),
      ),
      DropdownMenuItem(
        value: 'Cook',
        child: Text(_isEnglishSelected ? 'Cook' : 'रसोइया'),
      ),
      DropdownMenuItem(
        value: 'House Maids',
        child: Text(_isEnglishSelected ? 'House Maids' : 'घर सहायक'),
      ),
      DropdownMenuItem(
        value: 'Service Staff',
        child: Text(_isEnglishSelected ? 'Service Staff' : 'सेवा कर्मचारी'),
      ),
      DropdownMenuItem(
        value: 'Carpenter',
        child: Text(_isEnglishSelected ? 'Carpenter' : 'बढ़ई'),
      ),
      DropdownMenuItem(
        value: 'Dry Cleaning Staff',
        child: Text(
            _isEnglishSelected ? 'Dry Cleaning Staff' : 'ड्राई क्लीनिंग सहायक'),
      ),
      DropdownMenuItem(
        value: 'Painter',
        child: Text(_isEnglishSelected ? 'Painter' : 'पेंटर'),
      ),
      DropdownMenuItem(
        value: 'Photographer',
        child: Text(_isEnglishSelected ? 'Photographer' : 'फोटोग्राफर'),
      ),
      DropdownMenuItem(
        value: 'Plumber',
        child: Text(_isEnglishSelected ? 'Plumber' : 'पलंबर'),
      ),
      DropdownMenuItem(
        value: 'Tailor',
        child: Text(_isEnglishSelected ? 'Tailor' : 'दर्जी'),
      ),
      DropdownMenuItem(
        value: 'Teacher',
        child: Text(_isEnglishSelected ? 'Teacher' : 'शिक्षक'),
      ),
      DropdownMenuItem(
        value: 'Electrician',
        child: Text(_isEnglishSelected ? 'Electrician' : 'बिजली मिस्त्री'),
      ),
      DropdownMenuItem(
        value: 'Washing Machine mechanic',
        child: Text(_isEnglishSelected
            ? 'Washing Machine mechanic'
            : 'वाशिंग मशीन मिस्त्री'),
      ),
      DropdownMenuItem(
        value: 'Vehicle Mechanic',
        child: Text(_isEnglishSelected ? 'Vehicle Mechanic' : 'कार मिस्त्री'),
      ),
      DropdownMenuItem(
        value: 'Makeup Artist',
        child: Text(_isEnglishSelected ? 'Makeup Artist' : 'मेक-अप अर्टिस्ट'),
      ),
      DropdownMenuItem(
        value: 'Hair Stylish',
        child: Text(_isEnglishSelected ? 'Hair Stylish' : 'हेयर स्टाइलिश'),
      ),
      DropdownMenuItem(
        value: 'Beauty Salon Staff',
        child:
            Text(_isEnglishSelected ? 'Beauty Salon Staff' : 'ब्यूटी पार्लर'),
      ),
      DropdownMenuItem(
        value: 'Factory Staff',
        child: Text(_isEnglishSelected ? 'Factory Staff' : 'फैक्टरी सहायक'),
      ),
      DropdownMenuItem(
        value: 'Gym/ Yoga Trainer',
        child:
            Text(_isEnglishSelected ? 'Gym/ Yoga Trainer' : 'जिम/योग ट्रेनर'),
      ),
      DropdownMenuItem(
        value: 'Hotel Staff',
        child: Text(_isEnglishSelected ? 'Hotel Staff' : 'होटल कर्मचारी'),
      ),
      DropdownMenuItem(
        value: 'Restaurant Staff',
        child:
            Text(_isEnglishSelected ? 'Restaurant Staff' : 'रेस्टोरेंट स्टाफ'),
      ),
      DropdownMenuItem(
        value: 'Hospital Nursing Staff',
        child: Text(_isEnglishSelected
            ? 'Hospital Nursing Staff'
            : 'अस्पताल नर्सिंग स्टाफ'),
      ),
      DropdownMenuItem(
        value: 'Hospital Ward boy',
        child: Text(
            _isEnglishSelected ? 'Hospital Ward boy' : 'अस्पताल वार्ड बॉय'),
      ),
      DropdownMenuItem(
        value: 'Air Conditioner Mechanic',
        child: Text(_isEnglishSelected
            ? 'Air Conditioner Mechanic'
            : 'एयर कंडीशनर मिस्त्री'),
      ),
      DropdownMenuItem(
        value: 'LED/TV Repair',
        child:
            Text(_isEnglishSelected ? 'LED/TV Repair' : 'एलईडी टीवी मिस्त्री'),
      ),
      DropdownMenuItem(
        value: 'Car Detailing Staff',
        child:
            Text(_isEnglishSelected ? 'Car Detailing Staff' : 'डिटेलिंग स्टाफ'),
      ),
      DropdownMenuItem(
        value: 'Car/Auto  Denter',
        child:
            Text(_isEnglishSelected ? 'Car/Auto  Denter' : 'कार / ऑटो डेंटर'),
      ),
      DropdownMenuItem(
        value: 'Car Painter',
        child: Text(_isEnglishSelected ? 'Car Painter' : 'कार पेंटर'),
      ),
      DropdownMenuItem(
        value: 'Mehndi Artist',
        child: Text(_isEnglishSelected ? 'Mehndi Artist' : 'मेहँदी अर्टिस्ट'),
      ),
      DropdownMenuItem(
        value: 'Others',
        child: Text(_isEnglishSelected ? 'Others' : 'अन्य'),
      ),
    ];
  }

  static Future<dynamic> expire_dialog(
      {required BuildContext context,
      required Function()? onTap,
      required String button,
      required String title,
      required String subTitle}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.25,
            height: MediaQuery.of(context).size.width / 1.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFFFF0000),
                        decorationThickness: 0,
                        //decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      subTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        decorationThickness: 0,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color(0xFF0098DA),
                      ),
                      child: Center(
                        child: Text(
                          button,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            decorationThickness: 0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
