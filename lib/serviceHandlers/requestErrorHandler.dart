import 'dart:async';

class RequestErrorHandler {
  final dynamic e;

  RequestErrorHandler(this.e);

  Map<String, dynamic> checkErrorType() {
    print(e.toString());

    switch (e.runtimeType) {
      case TimeoutException :
        var data = {
          "success": false,
          "message": "Request is taking longer than expected. Please try again."
        };
        return data;
      default:
        var data = {"success": false, "message": e.toString()};
        return data;
    }
  }
}
