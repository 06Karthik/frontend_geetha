import 'dart:js';

import 'package:flutter/cupertino.dart';

import 'modifyInquiryByUserState.dart';

class ModifyInquiryByUser extends StatefulWidget
{
  final Map<dynamic,dynamic> data;

  const ModifyInquiryByUser({Key? key, required this.data}) : super(key:key);


  @override
  State<ModifyInquiryByUser> createState() => ModifyInquiryByUserState(data);


}