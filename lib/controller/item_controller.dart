import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/services/inquiryService.dart';

import '../facade/errorResponse.dart';
import 'package:http/http.dart' as http;
import '../inquirylist/Item.dart';
import '../serviceHandlers/requestHandler.dart';
import '../utils/Global.dart';

class ItemController extends GetxController
{
     Item ? item;

     InquiryService inquiryService = InquiryService();

     static final String GetIdInquiryUrl =
         Global.url+"inquiry";

     TextEditingController carMarkController = TextEditingController();
     TextEditingController carNumberController = TextEditingController();
     TextEditingController submittedByController = TextEditingController();
     TextEditingController assignedToController = TextEditingController();
     String? carStatusByUser;
     TextEditingController questionController = TextEditingController();
     TextEditingController relevantDrawingController = TextEditingController();
     String? priority;
     String? shop;


     fetchUserData(String id)async
     {
          print("ITEM GET ");

          try {

               print(" GET one "+id);

               RequestHandler requestHandler = RequestHandler(GetIdInquiryUrl+"/$id");

               print (requestHandler.serviceUrl);


               http.Response response = await requestHandler.getById();


               if(response.statusCode == 200)
                    {


                        var inquiry =  jsonDecode(response.body);


                        item = Item.fromJson(inquiry);

                        carMarkController.text = inquiry["carMark"];

                        carNumberController.text = inquiry["carNumber"];

                        carStatusByUser = inquiry["carStatus"];

                        submittedByController.text = inquiry["submittedBy"];

                         shop = inquiry["shop"];

                        questionController.text = inquiry["questions"];

                        relevantDrawingController.text = inquiry["relevantDrawings"];

                        priority = inquiry["priority"];






                    }


          } catch (e) {
               print(e);
               return ErrorResponse.fromMessage(e.toString());
          }


          }





}