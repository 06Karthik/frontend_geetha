import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestStatusHandler {
  final http.Response response;

  RequestStatusHandler(this.response);

  dynamic checkKnownStatusCode() async {
    var data = response.body;

    Map<String, dynamic>? decodedData = {
      'success': false,
      'message': '',
    };

    try {
      decodedData = jsonDecode(data);
      print("handler");


    } catch (e) {
      decodedData = {"success": false};
    }
    decodedData ??= {"success": false};

    switch (response.statusCode) {
      case 200:
        {
          decodedData["success"] = true;

          print(decodedData["results"]);


          print("1000");

          return decodedData;
        }
      case 300:
        {
          decodedData["success"] = false;
          decodedData["message"] = 'Something went wrong on our end. (300)';
          return decodedData;
        }
      case 401:
        {
          //Unauthorized
          decodedData["success"] = false;
          if (decodedData["message"] == null) {
            decodedData["message"] = 'Something went wrong on our end. (401)';
          }
          return decodedData;
        }
      case 400:
        {
          //Unauthorized
          decodedData["success"] = false;
          if (decodedData["message"] == null) {
            decodedData["message"] = 'Something went wrong on our end. (400)';
          }
          return decodedData;
        }
      case 403:
        {
          //permission denied
          decodedData["success"] = false;
          if (decodedData["message"] == null) {
            decodedData["message"] = 'Something went wrong on our end. (403)';
          }
          return decodedData;
        }

      case 404:
        {
          decodedData["success"] = false;
          if (decodedData["message"] == null) {
            decodedData["message"] = 'Something went wrong on our end. (404)';
          }
          return decodedData;
        }
      case 500:
        {
          //permission denied
          decodedData["success"] = false;
          if (decodedData["message"] == null) {
            decodedData["message"] = 'Something went wrong on our end. (500)';
          }
          return decodedData;
        }
      case 503:
        {
          decodedData["success"] = false;
          decodedData["message"] = 'Service temporarily unavailable!';
          return decodedData;
        }
      default:
      // Generic Handler
        decodedData["success"] = false;
        decodedData["message"] = jsonDecode(response.body)['message'] ??
            'Something went wrong on our end!';
        return decodedData;
    }
  }
}
