import 'dart:convert';
import '../providers/sessionProvider.dart';
import 'package:http/http.dart' as http;
import '../serviceHandlers/requestErrorHandler.dart';
import '../serviceHandlers/requestStatusHandler.dart';

import '../main.dart';


class RequestHandler {
  final Uri serviceUrl;

  RequestHandler(String serviceUrl) : serviceUrl = Uri.parse(serviceUrl);



  Map<String, String> headers = {
     'Content-type': 'application/json',
     'Accept': 'application/json',
    // 'encoding': 'utf-8',
    // 'Access-Control-Allow-Origin': '*',
  };

  Future createPost(var body) async {
    try {
      dynamic res = await http.post(serviceUrl, headers: headers, body: body);
      if (res != null) {
        if (res.statusCode == 401) {
          getIt.call<Session>().logOut();
        }

        RequestStatusHandler requestStatusHandler = RequestStatusHandler(res);
        return requestStatusHandler.checkKnownStatusCode();
      }
    } catch (e) {
      RequestErrorHandler errorHandler = RequestErrorHandler(e);
      return errorHandler.checkErrorType();
    }
  }

  Future createPostWithAuthHeaders(
      var body,
      Map<String, String>? headersWithAuth,
      ) async {
    try {
      dynamic res = await http
          .post(serviceUrl, headers: headersWithAuth, body: body)
          .timeout(const Duration(seconds: 300));
      if (res != null) {
        if (res.statusCode == 401) {
          getIt.call<Session>().logOut();
        }

        RequestStatusHandler requestStatusHandler = RequestStatusHandler(res);
        return requestStatusHandler.checkKnownStatusCode();
      }
    } catch (e) {
      RequestErrorHandler errorHandler = RequestErrorHandler(e);
      return errorHandler.checkErrorType();
    }
  }

  Future getById() async {
    try {


      http.Response response = await http.get(serviceUrl, headers: headers);

      print("Get response ");

      if (response != null) {
        if (response.statusCode == 401) {
          getIt.call<Session>().logOut();
        }


        return response;
      }
    } catch (e) {
      print(e);
      RequestErrorHandler errorHandler = RequestErrorHandler(e);
      return errorHandler.checkErrorType();
    }
  }


  Future modify(var body) async {
    try {

      print("modify http "+body);

      print(serviceUrl);

      print(headers);


      dynamic res = await http.put(serviceUrl, headers: headers, body: body);

      print("response "+res);

      if (res != null) {
        if (res.statusCode == 401) {
          getIt.call<Session>().logOut();
        }

        RequestStatusHandler requestStatusHandler = RequestStatusHandler(res);
        return requestStatusHandler.checkKnownStatusCode();
      }
    } catch (e) {
      print(e);
      RequestErrorHandler errorHandler = RequestErrorHandler(e);
      return errorHandler.checkErrorType();
    }
  }

  Future createPatchWithAuthHeaders(
      var body, Map<String, String>? headersWithAuth) async {
    try {
      dynamic res = await http
          .patch(serviceUrl, headers: headersWithAuth, body: body)
          .timeout(const Duration(seconds: 300));
      if (res != null) {
        if (res.statusCode == 401) {
          getIt.call<Session>().logOut();
        }

        RequestStatusHandler requestStatusHandler = RequestStatusHandler(res);
        return requestStatusHandler.checkKnownStatusCode();
      }
    } catch (e) {
      RequestErrorHandler errorHandler = RequestErrorHandler(e);
      return errorHandler.checkErrorType();
    }
  }

  Future createPostWithAuthHeadersOnly(
      Map<String, String>? headersWithAuth,
      ) async {
    try {
      dynamic response = await http
          .post(serviceUrl, headers: headersWithAuth)
          .timeout(const Duration(seconds: 300));

      if (response != null) {
        if (response.statusCode == 401) {
          getIt.call<Session>().logOut();
        }

        RequestStatusHandler requestStatusHandler =
        RequestStatusHandler(response);
        return requestStatusHandler.checkKnownStatusCode();
      }
    } catch (e) {
      RequestErrorHandler errorHandler = RequestErrorHandler(e);
      return errorHandler.checkErrorType();
    }
  }

  Future createDelete(Map<String, String>? headersWithAuth) async {
    try {
      dynamic response = await http
          .delete(serviceUrl, headers: headersWithAuth)
          .timeout(const Duration(seconds: 300));

      if (response != null) {
        if (response.statusCode == 401) {
          getIt.call<Session>().logOut();
        }

        RequestStatusHandler requestStatusHandler =
        RequestStatusHandler(response);
        return requestStatusHandler.checkKnownStatusCode();
      }
    } catch (e) {
      RequestErrorHandler errorHandler = RequestErrorHandler(e);
      return errorHandler.checkErrorType();
    }
  }

  Future getDataWithAuthHeaders(Map<String, String>? headersWithAuth) async {
    try {
      http.Response response = await http
          .get(serviceUrl, headers: headersWithAuth)
          .timeout(const Duration(seconds: 40));
      RequestStatusHandler requestStatusHandler =
      RequestStatusHandler(response);
      if (response.statusCode == 401) {
        getIt.call<Session>().logOut();
      }

      return requestStatusHandler.checkKnownStatusCode();
    } catch (e) {
      RequestErrorHandler errorHandler = RequestErrorHandler(e);
      return errorHandler.checkErrorType();
    }
  }

  Future get() async {
    try {
      http.Response response = await http
          .get(serviceUrl, headers: headers)
          .timeout(const Duration(seconds: 40));
      if (response.statusCode == 401) {
        getIt.call<Session>().logOut();     }

      return response;
    } catch (e) {
      RequestErrorHandler errorHandler = RequestErrorHandler(e);
      return errorHandler.checkErrorType();
    }
  }

  Future getDataWithAuthHeadersForList(
      Map<String, String>? headersWithAuth,
      ) async {
    try {
      http.Response response = await http
          .get(serviceUrl, headers: headersWithAuth)
          .timeout(const Duration(seconds: 40));
      if (response.statusCode == 401) {
        getIt.call<Session>().logOut();
      }

      return jsonDecode(response.body);
    } catch (e) {
      RequestErrorHandler errorHandler = RequestErrorHandler(e);
      return errorHandler.checkErrorType();
    }
  }



}