import 'package:json_annotation/json_annotation.dart';
class User {
  /*
  This class encapsulates the json response from the api
  {
      'userId': '1908789',
      'username': username,
      'name': 'Peter Clarke',
      'lastLogin': "23 March 2020 03:34 PM",
      'email': 'x7uytx@mundanecode.com'
  }
  */
  late String _username;
  late String _name;
  late String _accessToken;
  late String _expiresAt;
  late List<dynamic> _roles;

  // constructor
  User({
    username = "",
    name= "",
    accessToken ="",
    expiresAt ="",
    roles
  }) {
_username = username;
this._name = name;
this._accessToken = accessToken;
this._expiresAt = expiresAt;
_roles = roles;
}

// Properties

String get username => _username;
set username(String username) => _username = username;
String get name => _name;
set name(String name) => _name = name;
String get accessToken => _accessToken;
set accessToken(String accessToken) => _accessToken = accessToken;
String get expiresAt => _expiresAt;
set expiresAt(String expiresAt) => _expiresAt = expiresAt;

// create the user object from json input
User.fromJson(Map<String, dynamic> json) {
_accessToken = json['accessToken'];
_username = json['username'];
_name = json['name'];
_expiresAt = json['expiresAt'];
_roles = json['roles'];
}

// exports to json
Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['expiresAt'] = this._expiresAt;
data['username'] = this._username;
data['name'] = this._name;
data['accessToken'] = this._accessToken;
data['roles'] = this._roles;
return data;
}
}
