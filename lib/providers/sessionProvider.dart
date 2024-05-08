
import 'package:flutter/material.dart';

import '../facade/user.dart';

class Session extends ChangeNotifier {
  String? _token;
  User? _user;

  String? get token => _token;
  User? get user => _user;

  void setSession(dynamic session) async {
    _user = User.fromJson(session);
    _token = _user!.accessToken;
    notifyListeners();
  }

  void logOut() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}
