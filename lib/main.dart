import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:provider/provider.dart';
import 'package:untitled/engineer/engineer_inquiry.dart';
import 'package:untitled/login/login.dart';
import 'package:untitled/providers/inquiryProvider.dart';
import 'package:untitled/providers/loginProvider.dart';
import 'package:untitled/providers/sessionProvider.dart';
import 'package:untitled/utils/Global.dart';

import 'addInquiry/addInquiry.dart';
import 'dashboard/dashboardPage.dart';
import 'inquirylist/listpage.dart';
import 'modifyInquiryByUser/modifyInquiryByUser.dart';

GetIt getIt = GetIt.I;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {


  runApp(Home());
}

class Home extends StatelessWidget with GetItMixin {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Session>(
            create: (_) => Session(),
          ),
          ChangeNotifierProvider<Inquiry>(
            create: (_) => Inquiry(),
          ),

           ChangeNotifierProvider<LoginProvider>(
            create: (_) => LoginProvider(),
          ),

        ],
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              onGenerateRoute: (settings) {
                final page = _getPageWidget(settings,context);
                if (page != null) {
                  return PageRouteBuilder(
                      settings: settings,
                      pageBuilder: (_, __, ___) => page,
                      transitionsBuilder: (_, anim, __, child) {
                        return FadeTransition(
                          opacity: anim,
                          child: child,
                        );
                      });
                }
                return null;
              });
        });
  }

  Widget? _getPageWidget(RouteSettings settings,BuildContext context) {
    if (settings.name == null) {
      return null;
    }


    Object? args = settings.arguments;

    final uri = Uri.parse(settings.name!);
    switch (uri.path) {
      case '/menu':
        return const DashboardPage();
      case '/list':
        return const ListPage();
      case '/add':
        return const AddInquiry();
      case '/':

        var accessToken;

        if(Uri.base.toString().contains("access_token="))
          {
              var idStart = Uri.base.toString().indexOf("access_token=") + "access_token=".length;

              var idEnd = min(Uri.base.toString().length - 1,Uri.base.toString().indexOf("&token_type="));

              accessToken = Uri.base.toString().substring(idStart,idEnd);

              Global.value.azureAccessToken = accessToken;

          }



        print(accessToken);

        return Global.value.azureAccessToken == " " ? const Login():const DashboardPage();

      case '/edit_user':
        String ? id;

        if (args is Map) {
          args.entries.forEach((e) {
            print('{ key: ${e.key}, value: ${e.value} }');

            id = e.value;
          });
        }
        return ModifyInquiryByUser(data: {"id": id});

      case "/engineer_inquiry":
        String ? id;

        if (args is Map) {
          args.entries.forEach((e) {
            print('{ key: ${e.key}, value: ${e.value} }');

            id = e.value;
          });
        }

        return EngineerInquiry(value: {"id": id});
    }

    return null;
  }


}
