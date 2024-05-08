import 'package:json_annotation/json_annotation.dart';

import '../inquirylist/Item.dart';
class InquiryList {
  /*
  This class encapsulates the json response from the api

        "id": "65ebd716c8d3dc3ea966cd3c",
        "carMark": "UTLX",
        "carNumber": "30334",
        "shop": "Evanston",
        "priority": "low",
        "submittedBy": "Jeff",
        "assignedTo": "Daniel",
        "carStatus": "Pre-Process",
        "action": "view"

  */
  late List<Item> _inquiryList;

  InquiryList(List<Item> inquiryList){
    _inquiryList= inquiryList;
  }


// Properties

  List<Item> get inquiryList => _inquiryList;
  set inquiryList(List<Item> inquiryList) => _inquiryList = inquiryList;


// create the object from json input
  InquiryList.fromJson(Map<String, dynamic> json) {
    print(json);
    _inquiryList = json['results'].map<Item> ((data) =>
       Item.fromJson (data)).toList ();

  }

// exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inquiryList'] = _inquiryList.map ((item) => item.toJson ()).toList ();

    return data;
  }
}