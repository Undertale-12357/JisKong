import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> seedPasses() async {
  final String baseUrl =
      'https://jiskong-default-rtdb.asia-southeast1.firebasedatabase.app';
  final Uri url = Uri.parse('$baseUrl/passes.json');

  print('Attempting to seed passes to: $url');

  try {
    // Initial data matching your PassDTO keys
    final Map<String, dynamic> initialPasses = {
      "template_day": {
        "type": "day",
        "expirationDate": DateTime.now()
            .add(const Duration(days: 1))
            .toIso8601String(),
        "isActive": true,
      },
      "template_monthly": {
        "type": "monthly",
        "expirationDate": DateTime.now()
            .add(const Duration(days: 30))
            .toIso8601String(),
        "isActive": true,
      },
    };

    // Using PATCH here so we don't delete existing passes if they exist
    final response = await http.patch(url, body: json.encode(initialPasses));

    if (response.statusCode == 200) {
      print('✅ Success! Passes node initialized in Firebase.');
    } else {
      print('❌ Failed: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}

void main() async {
  await seedPasses();
}
