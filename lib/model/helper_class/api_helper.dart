
import 'dart:convert';

import 'package:ai_chatboat/model/export_libreary.dart';
import 'package:http/http.dart' as http;


class ApiHelper {
  static final ApiHelper helper = ApiHelper._();

  ApiHelper._();

  factory ApiHelper() {
    return helper;
  }

  RxBool isLoad = false.obs;
  int? time;
  final String baseurl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyB9JVxZkKD0C9AnFCQBcFv-hs9o8SpE6So";

  Future<QnaModel?> getApiData(String question) async {
    var bodyToJson = {
      "contents": [
        {
          "parts": [
            {"text": question}
          ]
        }
      ]
    };

    String bodyData = jsonEncode(bodyToJson);
    final startTime=DateTime.now();
    try {
      http.Response data = await http.post(
        Uri.parse(baseurl),
        body: bodyData,
        headers: {"Content-Type": "application/json"},
      );

      if (data.statusCode == 200) {
        Map<String, dynamic> decodeData = jsonDecode(data.body);

        // Check if decodeData contains the expected keys
        if (decodeData.containsKey('candidates')) {
          var res = QnaModel.mapToModel(decodeData);
          final endTime=DateTime.now();

           var duration=endTime.difference(startTime).inMicroseconds;
           time=duration;
           print("object :$duration");
          return res;
        } else {
          print("Unexpected response structure: ${data.body}");
          return null;
        }
      } else {
        print("Request failed with status: ${data.statusCode}");
        // return null;
      }
    } catch (e) {
      print("Error during API call: $e");
      return null;
    }
    return null;
  }
}
