import 'package:flutter/material.dart';
import '../commonComponents/CheckBox.dart';
import '/addInquiry/addInquiry.dart';
import '/commonComponents/mainscaffold.dart';
import '/providers/inquiryProvider.dart';
import 'package:provider/provider.dart';

import '/inquirylist/Item.dart';

class AddInquiryState extends State<AddInquiry> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController carMarkController = TextEditingController();
  TextEditingController carNumberController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  TextEditingController submittedByController = TextEditingController();
  TextEditingController assignedToController = TextEditingController();
  TextEditingController carStatusController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController relevantDrawingController = TextEditingController();

  bool isChecked = false;

  List<CheckBox> checkBoxes = [];

  List<Map<String,dynamic>> dataList=[];

  String? priority;

  String? carStatusByUser;

  String? shop;

  List<dynamic> userCheckBoxList = [];


  @override
  void initState() {
    super.initState();

    context.read<Inquiry>().listCheckBoxes("token", "network");

  }


  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey < FormState > ();

    final _provider = context.watch<Inquiry>();
    final _model = _provider.boxList;


    return MainScaffold(

      route: '/add',
        value: 'User',

      body: Center(

        child: Container(

          alignment: Alignment.center,

          padding: const EdgeInsets.fromLTRB(10,1,150,1),

          margin: EdgeInsets.all(100.0),

          constraints: const BoxConstraints(),

          child: Column(

            children: [

              Row(

                mainAxisAlignment: MainAxisAlignment.start,

                children: [

                 Text("Add Inquiry"),


                ],


              ),


              SizedBox(height: 15),


              Column(

                mainAxisAlignment: MainAxisAlignment.center,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [


                      Row(

                            children: [

                          Expanded(

                                child: TextFormField(
                                decoration: const InputDecoration(
                                labelText: "Car Mark",
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8))),

                                hintText: "Eg:UTLX",
                                ),

                          controller: carMarkController,
                        ),
                      ),

                      SizedBox(width: 25),

                      Expanded(
                          child: ListTile(
                            subtitle:  TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Car Number",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8))),

                                hintText: 'Car Number',
                              ),


                              controller: carNumberController,
                            ),
                          )

                       ),

                          SizedBox(width:1),

                           Expanded(

                                child:ListTile(
                                     subtitle:  TextFormField(
                                     decoration: const InputDecoration(
                                      labelText: "Submitted By",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8))),

                                       hintText: 'Submitter Name',
                                ),
                                 controller: submittedByController,
                            ),  ),
                        ),


                      ],
                      ),

                    Column(


                        children: [


                          Row(

                          mainAxisAlignment: MainAxisAlignment.center,

                              children: [

                                  Expanded(

                                      child: ListTile(

                                       subtitle:  TextFormField(

                                      decoration: const InputDecoration(
                                      labelText: "Relevant Drawings",
                                      border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8))),
                                      hintText: 'RelevantDrawings',

                                      ),
                                      controller: relevantDrawingController,
                                      ),

                                  )

                                  ),


                                  Expanded(
                                      child : ListTile(
                                        subtitle: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(

                                          labelText: "Shop",

                                          border: OutlineInputBorder(),
                                          ),
                                          hint: const Text("Please Select"),

                                          value: shop,

                                          onChanged: (String? newValue) {
                                          setState(() {
                                          shop = newValue!;
                                          });
                                          },

                                          items: <String> ['Eddminton','Jofre',"Regima","Evanston"].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                          );
                                          }).toList(),


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

                                              print(item.value);

                                              _provider.values.entries.forEach((e) {
                                                print('{ key: ${e.key}, value: ${e.value} }');


                                                if(e.value == true && !userCheckBoxList.contains(item.value))
                                                  {
                                                       userCheckBoxList.add(item.value);
                                                  }

                                                if(e.value == false && userCheckBoxList.contains(e.key))
                                                  {
                                                     userCheckBoxList.remove(item.value);
                                                  }

                                              });

                                              print(userCheckBoxList);


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


                                            ),
                                            ],
                                            ),
                                            ],
                                            ),


                                  Column(

                                    children: [

                                        Row(

                                          children: [

                                            Expanded(
                                              child: ListTile(

                                              subtitle: DropdownButtonFormField<String>(
                                              decoration: const InputDecoration(


                                              labelText: "Priority",

                                              border: OutlineInputBorder(),
                                              ),
                                              hint: const Text("Please Select"),

                                              value: priority,

                                              onChanged: (String? newValue) {
                                              setState(() {
                                              priority = newValue!;
                                              });
                                              },


                                              items: <String>['pending','immediate',"assign","review"].map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                              );
                                              }).toList(),


                                              ),

                                              ),
                                              ),


                                        Expanded(

                                              child: ListTile(

                                                subtitle:  DropdownButtonFormField<String>(
                                                  decoration: const InputDecoration(

                                                    labelText: "Car Status",

                                                    border: OutlineInputBorder(),
                                                    ),
                                                   hint: const Text("Please Select"),

                                                  value: carStatusByUser,

                                                  onChanged: (String? newValue) {
                                                  setState(() {
                                                  carStatusByUser = newValue!;
                                                  });
                                                  },


                                                items: <String>['pre-processing','received',"actively being worked"].map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                                );
                                                }).toList(),

                                                ),

                                                ),
                                                )

                                                ],
                                                ),
                                                ],

                                                ),

                                  SizedBox(height: 20),


                                Column(

                                children: [

                                  TextField(

                                      maxLines: 4,
                                      decoration: const InputDecoration(


                                      labelText: "Request",

                                      border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8))),
                                      hintText: 'Request',
                                      ),
                                      controller: questionController,


                                )

                                ]


                                ),


                  SizedBox(height: 20),

              Column(

                children: [

                 Row(

                        children: [

                          SizedBox(
                            height: 10,
                            width: 10,
                          ),

                          ElevatedButton(

                              onPressed: () async{

                                String carMark = carMarkController.text;

                                String carNumber = carNumberController.text;

                                String carStatus = carStatusByUser.toString();

                                String submittedBy = submittedByController.text;

                                String relevantDrawing = relevantDrawingController.text;

                                String question = questionController.text;

                                late String id = "0";

                                Item item = Item(carMark: carMark, carNumber: carNumber, carStatus: carStatus,relevantDrawings: relevantDrawing,questions: question, submittedBy: submittedBy,checkList: userCheckBoxList, priority: priority.toString(), shop: shop.toString());

                                print(userCheckBoxList);

                                print(item);


                                Provider.of<Inquiry>(context,listen: false).addInquiry("token", "network", item);

                              },

                             child: Text("Submit")),


                        ],



                      ),
                  ],
                  ),
                  ],
                  ),
            ],
          )
    ),

      )

    );

  }





  Widget buildPage(BuildContext context0)
  {

    return build(context);
  }

  }