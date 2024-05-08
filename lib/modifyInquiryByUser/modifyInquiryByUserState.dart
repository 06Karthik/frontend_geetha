import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:untitled/controller/item_controller.dart';

import '../commonComponents/CheckBox.dart';
import '../commonComponents/mainscaffold.dart';
import '../inquirylist/Item.dart';
import '../providers/inquiryProvider.dart';
import 'modifyInquiryByUser.dart';

class ModifyInquiryByUserState extends State<ModifyInquiryByUser>
{

  final Map<dynamic,dynamic> value;

   ModifyInquiryByUserState(this.value);


  bool isChecked = false;


  List<CheckBox> checkBoxes = [];

  List<Map<String,dynamic>> dataList=[];

  late String id ;


  @override
  void initState() {
    super.initState();
    context.read<Inquiry>().listCheckBoxes("token", "network");

  }

  @override
  Widget build(BuildContext context) {

    value.entries.forEach((e) {
      print('{ key: ${e.key}, value: ${e.value} }');

      id = e.value;

    });


    ItemController itemController = Get.put(ItemController());

    itemController.fetchUserData(id);


    final _provider = context.watch<Inquiry>();
    final _model = _provider.boxList;


    return MainScaffold(

        route: "/edit_user",
        value: 'User',

        body: Column(

            children: [

              Row(

                children: [


                  Expanded(
                      child: ListTile(


                        subtitle: Text("Modify Inquiry"),

                      )

                  )

                ],

              ),
              Row(

                children: [

                  Expanded(
                    flex: 1,
                    child:ListTile(

                      subtitle:  TextFormField(
                        maxLength: 5,
                        decoration: const InputDecoration(
                          labelText: "Car Mark",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),

                          hintText: "Eg:UTLX",
                        ),

                          controller: itemController.carMarkController,
                      ),),
                  ),


                  Expanded(
                      flex: 1,
                      child: ListTile(
                        subtitle:  TextFormField(
                          maxLength: 25,
                          decoration: const InputDecoration(
                            labelText: "Car Number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8))),

                            hintText: 'Car Number',
                          ),


                          controller: itemController.carNumberController,
                        ),
                      )

                  ),


                  Expanded(
                    child:ListTile(
                      subtitle:  TextFormField(
                        maxLength: 150,
                        decoration: const InputDecoration(
                          labelText: "Submitted By",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),

                          hintText: 'Submitter Name',
                        ),
                        controller: itemController.submittedByController,
                      ),),
                  ),

                ],

              ),

              Row(

                children: [

                  Flexible(
                    flex: 1,
                    child: ListTile(

                      subtitle:  TextFormField(

                        decoration: const InputDecoration(
                          labelText: "Relevant Drawings",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          hintText: 'RelevantDrawings',

                        ),
                        controller: itemController.relevantDrawingController,
                      ),),
                  ),

                  Flexible(
                    flex: 1,
                    child: ListTile(
                      title: Text("Shop"),
                      subtitle: DropdownButton<String>(
                        hint: Text("Please select"),
                        value:itemController.shop,
                        items: <String>['pending','immediate',"assign","review"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 19),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            itemController.shop = newValue??"";
                          });
                        },




                      ),
                    ),
                  ),


                  Flexible(
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(

                        shrinkWrap: true,

                        itemCount: _model?.boxList.length,
                        itemBuilder: (context, index) {
                          final item = _model?.boxList[index];
                          return CheckboxListTile(
                            value: _provider.isChecked(item!.value),
                            onChanged: (value) {
                              setState(() {
                                _provider.toggleItem(item.value) ;

                                print(_provider.values);


                                print(_provider.isChecked(item!.value));
                              });
                            },
                            title: Text(
                              item.value,
                              style: const TextStyle(color: Colors.black87),
                            ),
                          );},
                      ),
                    ),
                  )


                ],


              ),
              SizedBox(
                width: 1,
              ),
              Row(

                children: [


                  SizedBox(
                    width: 1,
                  ),

                   Expanded(
                    child: ListTile(
                      title: Text("Priority"),
                      subtitle: DropdownButton<String>(
                        hint: Text("Please select"),
                        value:itemController.priority,
                        items: <String>['pending','immediate',"assign","review"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 19),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            itemController.priority = newValue??"";
                          });
                        },




                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(

                      title: Text("Car Status"),
                      subtitle: DropdownButton<String>(
                        hint: Text("Please select"),

                        value:itemController.carStatusByUser,
                        items: <String>['pending','immediate',"assign","review"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 19),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            itemController.carStatusByUser = newValue??"";
                          });
                        },




                      ),
                    ),

                  ),

                  SizedBox(
                    width: 1,
                  ),

                ],

              ),

              Row(

                children: [

                  Flexible(

                    flex:1,

                    child: ListTile(

                      subtitle:  TextFormField(
                        maxLength: 250,
                        decoration: const InputDecoration(


                          labelText: "Request",

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          hintText: 'Request',
                        ),
                        controller: itemController.questionController,
                      ),

                    ),
                  ),


                ],

              ),

              Row(

                children: [


                  Expanded(

                    child: ListTile(

                      subtitle:  TextFormField(
                        decoration: const InputDecoration(

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          hintText: 'Attachment',
                        ),
                      ),),
                  ),

                  SizedBox(
                    width: 1,
                  ),

                ],
              ),

              Row(


                children: [

                  SizedBox(
                    height: 10,
                    width: 10,
                  ),

                  ElevatedButton(
                      onPressed: () async{

                        String carMark = itemController.carMarkController.text;

                        String carNumber = itemController.carNumberController.text;

                        String carStatus = itemController.carStatusByUser.toString();

                        String submittedBy = itemController.submittedByController.text;

                        String relevantDrawing = itemController.relevantDrawingController.text;

                        String question = itemController.questionController.text;

                        Item item = Item(carMark: carMark, carNumber: carNumber, carStatus: carStatus,relevantDrawings: relevantDrawing,questions: question, submittedBy: submittedBy,checkList: [], priority: itemController.priority.toString(), shop: itemController.shop.toString());

                        print(item.carNumber);

                        Provider.of<Inquiry>(context,listen: false).modifyInquiry("token", "network", item,id);

                      },

                      child: Text("Submit")),


                ],



              )







            ]




        ),




    );
  }



}