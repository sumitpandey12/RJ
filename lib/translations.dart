import 'package:http/http.dart' as http;
import 'dart:convert';

class TranslationService {
  static Future<List<String>?> translateText(String text) async {
    final apiKey =
        "AIzaSyBLLuH_HREX5QU0CbdJlmYOhSWPullNmPc"; // Replace with your actual API key

    // Define the target languages
    final targetLanguages = ["hi", "en"];

    final translations = <String>[];

    for (final targetLang in targetLanguages) {
      final url = Uri.parse(
          "https://translation.googleapis.com/language/translate/v2?key=$apiKey");

      // Define the payload data for each target language
      final data = {
        "q": text,
        "target": targetLang,
      };

      // Make a POST request to the Google Translate API for each target language
      final response = await http.post(
        url,
        body: data,
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final translatedText =
            result['data']['translations'][0]['translatedText'];
        translations.add(translatedText);
      } else {
        print("Translation failed with status code: ${response.statusCode}");
        return null;
      }
    }

    return translations;
  }
}
