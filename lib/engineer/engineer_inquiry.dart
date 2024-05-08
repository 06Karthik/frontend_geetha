
import 'package:flutter/cupertino.dart';

import 'engineer_inquiry_form_state.dart';

class EngineerInquiry extends StatefulWidget
{

  final Map<dynamic,dynamic> value;


  const EngineerInquiry({Key? key, required this.value}) : super(key:key);





  @override
  State<EngineerInquiry> createState() => EngineerInquiryFormState(value);



}