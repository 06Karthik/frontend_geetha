import 'dart:async';
import 'dart:convert';

import '../facade/user.dart';
import '../facade/errorResponse.dart';
import '../serviceHandlers/requestHandler.dart';
import '../utils/Global.dart';


class AuthenticationService {
  static final String loginUrl =
      Global.url + '/v1.0/authenticate';

  Future login(String username, String password) async {
    Map<String, dynamic> jsonMap = {"username": username, "password": password};

    var request = json.encode(jsonMap);

    try {
      RequestHandler requestHandler = RequestHandler(loginUrl);

      dynamic res = await requestHandler.createPost(request);

      if (res != null) {
        Map<String, dynamic> formattedResponse = await res;

        if (formattedResponse["success"] == true) {
          formattedResponse["username"] = username;
          return User.fromJson(formattedResponse);
        } else {
          return ErrorResponse.fromError(formattedResponse);
        }
      } else {
        return ErrorResponse.fromMessage("No response received from backend.");
      }
    } catch (e) {
      print(e.toString());
      return ErrorResponse.fromMessage(e.toString());
    }
  }
}