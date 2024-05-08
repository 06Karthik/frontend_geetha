



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:openid_client/openid_client_browser.dart' as open_id;
import 'package:untitled/utils/Global.dart';


class LoginProvider extends ChangeNotifier {



  Future<bool> getUser(Uri uri, String clientId, List<String>scopes) async {

    var issuer = await open_id.Issuer.discover(uri);

    var client = open_id.Client(issuer, clientId);


    var authenticator = open_id.Authenticator(client, scopes: scopes);


    var token = await authenticator.credential;


    print(token);

    authenticator.authorize();

    notifyListeners();

    Global.value.token;

    return true;
  }


}