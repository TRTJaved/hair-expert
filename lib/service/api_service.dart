import 'package:hair_expert_poc/models/time_slot_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String baseUrlCalApi = "https://api.cal.com/slots";

class ApiService {
  static Future<TimeSlotModel> fetchUserAvailableSlots({
    required String eventTypeId,
    required String startTime,
    required String endTime,
    required String apiKey,
    required String timeZone,
  }) async {
    final url = Uri.parse(baseUrlCalApi);
    print(url);

    final queryParams = {
      'eventTypeId': eventTypeId,
      'startTime': startTime,
      'endTime': endTime,
      'apiKey': apiKey,
      'timeZone': timeZone,
    };
    print(queryParams);
    final response = await http.get(url.replace(queryParameters: queryParams));
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return TimeSlotModel.fromJson(jsonData);
    } else {
      throw Exception(
          'Failed to fetch user available slots. ${response.body} ${response.statusCode}');
    }
  }
}
