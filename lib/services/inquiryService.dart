import 'dart:convert';




import '../commonComponents/CheckBoxList.dart';
import '../facade/errorResponse.dart';
import '../facade/inquiryList.dart';

import '../serviceHandlers/requestHandler.dart';
import '../utils/Global.dart';

class InquiryService {

  static final String listInquiriesUrl =
      Global.url + 'inquiries';

  static final String addInquiryUrl =
      Global.url +'inquiry';

  static final String modifyInquiryUrl =
      Global.url+"inquiry";

  static final String listCheckBoxesUrl =
      Global.url + 'checkBoxList';

  static final String addEngineerWorkItemUrl =
      Global.url+'engineer_item';


  Future addInquiry(String accessToken, String network,String body) async {
    try {
      RequestHandler requestHandler = RequestHandler(addInquiryUrl);

      print(" HERE "+body);

      dynamic res = await requestHandler.createPost(body);

      if (res != null) {
        String responseString = res.body;

        print(responseString);
      }
    } catch (e) {
      print(e.toString());
      return ErrorResponse.fromMessage(e.toString());
    }
  }



  Future listCheckBoxes (String accessToken, String network) async {

    try {
      RequestHandler requestHandler = RequestHandler(listCheckBoxesUrl);

      dynamic res = await requestHandler.get();

      if (res != null) {
        Map<String, dynamic> formattedResponse = await json.decode(res.body);

        if (formattedResponse["success"] == true) {
          print(formattedResponse);
          return CheckBoxList.fromJson(formattedResponse);
        } else {
          return ErrorResponse.fromError(formattedResponse);
        }
      } else {
        return ErrorResponse.fromMessage("No response received from backend.");
      }
    } catch (e) {
      print(e.toString());
      return ErrorResponse.fromMessage(e.toString());
    }
  }

  Future modifyInquiry(String accessToken, String network,String body,String id) async {
    try {

      RequestHandler requestHandler = RequestHandler(modifyInquiryUrl+"/$id");

      print (requestHandler.serviceUrl);

      print(" Modify Inquiry  "+body);

      dynamic res = await requestHandler.modify(body);

      if (res != null) {
        String responseString = res.body;

        print(responseString);
      }
    } catch (e) {
      print(e);
      return ErrorResponse.fromMessage(e.toString());
    }
  }



  Future getInquiriesList(String accessToken, String network) async {

    try {
      RequestHandler requestHandler = RequestHandler(listInquiriesUrl);

      dynamic res = await requestHandler.get();

      if (res != null) {
        Map<String, dynamic> formattedResponse = await json.decode(res.body);

        if (formattedResponse["success"] == true) {
          print(formattedResponse);
          return InquiryList.fromJson(formattedResponse);
        } else {
          return ErrorResponse.fromError(formattedResponse);
        }
      } else {
        return ErrorResponse.fromMessage("No response received from backend.");
      }
    } catch (e) {
      print(e.toString());
      return ErrorResponse.fromMessage(e.toString());
    }
  }


  Future addEngineerWorkItem(String accessToken, String network,String body) async {
    try {
      RequestHandler requestHandler = RequestHandler(addEngineerWorkItemUrl);

      dynamic res = await requestHandler.createPost(body);

      if (res != null) {
        String responseString = res.body;

        print(responseString);
      }
    } catch (e) {
      print(e.toString());
      return ErrorResponse.fromMessage(e.toString());
    }
  }



}
