// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../singleton_class/query_model.dart';
//
// class ApiHelper {
//   static final ApiHelper helper = ApiHelper._();
//
//   ApiHelper._();
//
//   factory ApiHelper() {
//     return helper;
//   }
//
//   final String baseurl =
//       "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyB9JVxZkKD0C9AnFCQBcFv-hs9o8SpE6So";
//
//   // String key = "AIzaSyB9JVxZkKD0C9AnFCQBcFv-hs9o8SpE6So";
//
//   Future<QnaModel?> getApiData(
//     String question,
//   ) async {
//     var bodyToJson = {
//       "contents": [
//         {
//           "parts": [
//             {"text": question}
//           ]
//         }
//       ]
//     };
//
//     // String url = baseurl + key;
//     String bodyData = jsonEncode(bodyToJson);
//     http.Response data = await http.post(Uri.parse(baseurl),
//         body: bodyData, headers: {"Content-Type": "application/json"});
//     if (data.statusCode == 200) {
//       // QnaModel res = qnaModelFromJson(data.body);
//       Map<String, dynamic> decodeData = jsonDecode(data.body);
//       var res = QnaModel.mapToModel(decodeData);
//       return res;
//     }
//     return null;
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import '../singleton_class/query_model.dart';

class ApiHelper {
  static final ApiHelper helper = ApiHelper._();

  ApiHelper._();

  factory ApiHelper() {
    return helper;
  }

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
