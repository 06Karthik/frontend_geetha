import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:untitled/engineer/engineer_work.dart';
import '../commonComponents/CheckBoxList.dart';
import '../facade/inquiryList.dart';

import '../inquirylist/Item.dart';
import '../services/inquiryService.dart';

class Inquiry extends ChangeNotifier {
  InquiryList? _inquiryList;
  late InquiryList _editedList;
  InquiryList? get inquiryList => _inquiryList;

  CheckBoxList? _checkBoxList;

  late CheckBoxList _editedBox;

  final InquiryService _inquiryService = InquiryService();

  CheckBoxList? get boxList => _checkBoxList;

  List<Item> items = [];

  Map<String, bool> _checkedValues = {};

  Map<String, bool> get values => _checkedValues;



  setInquiryList() {
    if (_inquiryList != null) {
      _editedList = InquiryList.fromJson(_inquiryList!.toJson());
      notifyListeners();
    }
  }

  setCheckBoxes() {
    if (_checkBoxList != null) {

      _editedBox = CheckBoxList.fromJson(_checkBoxList!.toJson());

      notifyListeners();
    }
  }

  Future<bool> getInquiryList(String token, String network) async {
    var response = await _inquiryService.getInquiriesList(token, network);
    if (response is InquiryList) {
      _inquiryList = response;
      notifyListeners();
      return true;
    }
    return false;
  }


  Future<bool> listCheckBoxes(String token, String network) async {
    var list = await _inquiryService.listCheckBoxes(token, network);
    if (list is CheckBoxList) {

      _checkedValues.clear();
      _checkBoxList = list;
      for (var item in _checkBoxList!.boxList) {
        _checkedValues[item.value] = false; // Initialize as unchecked
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  bool isChecked(String item) {
    return _checkedValues[item] ?? false;
  }


  void toggleItem(String item) {
    _checkedValues[item] = !_checkedValues[item]!;
    notifyListeners();

  }



  Future<bool>addInquiry(String token,String network,Item itemValue) async {

    print(itemValue);

    Map map = {

      "carMark" : itemValue.carMark,
      "carNumber" : itemValue.carNumber,
      "carStatus" : itemValue.carStatus,
      "submittedBy" : itemValue.submittedBy,
      "priority" : itemValue.priority,
      "relevantDrawings": itemValue.relevantDrawings,
      "shop":itemValue.shop,
      "questions":itemValue.questions,
      "checkList":itemValue.checkList,
    };

    Item item = await _inquiryService.addInquiry(token, network,json.encode(map));

        items.add(item);

        notifyListeners();

        return true;

  }


  Future<bool>modifyInquiry(String token,String network,Item itemValue,String id) async {


    Map map = {

      "id": id,
      "carMark" : itemValue.carMark,
      "carNumber" : itemValue.carNumber,
      "carStatus" : itemValue.carStatus,
      "submittedBy" : itemValue.submittedBy,
      "priority" : itemValue.priority,
      "relevantDrawings": itemValue.relevantDrawings,
      "shop":itemValue.shop,
      "questions":itemValue.questions,
    };

    Item item = await _inquiryService.modifyInquiry(token, network, json.encode(map),id);

   // items.add(item);

    notifyListeners();

    return true;

  }



  Future<bool>addEngineerWorkItem(String token,String network,EngineerWork work) async {


    Map map = {

     "userId" : work.userId,

      "engineerName" : work.engineerName,

      "workStatus" : work.workStatus,

      "workTime" : work.workTime,

      "remarks" : work.remarks

    };


    EngineerWork engineerWork = await _inquiryService.addEngineerWorkItem("token","network",json.encode(map));

    notifyListeners();

    return true;

  }















}