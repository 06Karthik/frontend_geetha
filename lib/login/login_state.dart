

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/login/login.dart';

import '../providers/loginProvider.dart';

class LoginState extends State<Login>
{

  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    var tenantId = "1d0c38ac-c828-4447-ac9a-f638ea212db2";

    var clientId = "da388699-156c-4383-bb23-6411b8fa3e73";


    var scope = "api://da388699-156c-4383-bb23-6411b8fa3e73/view";



    return Scaffold(


      appBar: AppBar(title: const Text("Azure"),),



      body :  Center(



        child:

              ElevatedButton(

                child:

                    const Text("Login"),


              onPressed: ()
              {


                 Provider.of<LoginProvider>(context,listen: false).getUser(Uri.parse("https://login.microsoftonline.com/$tenantId/v2.0"), clientId, [scope]);

              }

              
              ),

      ),

    );


  }




}