import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:untitled/engineer/engineer_inquiry.dart';
import 'package:untitled/engineer/engineer_work.dart';

import '../commonComponents/mainscaffold.dart';
import '../controller/item_controller.dart';
import '../providers/inquiryProvider.dart';

class EngineerInquiryFormState extends State<EngineerInquiry>
{

  TextEditingController engineerNameController = TextEditingController();

  TextEditingController workTimeController = TextEditingController();

  TextEditingController remarkController = TextEditingController();

   String ? work;


  final Map<dynamic,dynamic> value;

  EngineerInquiryFormState(this.value);

  String? priority;

  String? shop;


  String? carStatusByUser;


  bool isVisible = true;

  late String id;

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

    print(itemController.shop);


    return MainScaffold(

      route: '/engineer_inquiry',
      value: 'User',

      body: Center(

        child: Container(

          alignment: Alignment.center,

          padding: const EdgeInsets.fromLTRB(10,1,150,1),

          margin: EdgeInsets.all(100.0),

          constraints: const BoxConstraints(),

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Container(

                  width: double.maxFinite,

                  child:

                    Text("Modify Inquiry")


                ),


                SizedBox(height: 15),







                Row(

                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [

                    Expanded(

                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Car Mark",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),

                          hintText: "Eg:UTLX",
                        ),

                        controller: itemController.carMarkController,
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


                            controller: itemController.carNumberController,
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
                          controller: itemController.submittedByController,
                        ),),
                    ),


                  ],
                ),

                Column(


                  children: [


                    Row(


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
                              controller: itemController.relevantDrawingController,
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

                              value: itemController.shop,

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

                              value: itemController.priority,

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

                                value: itemController.carStatusByUser,

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
                             controller: itemController.questionController,


                           )

                      ]


                    ),

                SizedBox(height: 25),

                Divider(

                  thickness: 10,


                ),

                Visibility(

                  visible: isVisible,

                  child: Container(

                    alignment: Alignment.centerLeft,

                    padding: const EdgeInsets.fromLTRB(1,1,100,1),

                    margin: EdgeInsets.all(100.0),

                    constraints: BoxConstraints(),


                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [


                        Text("Item for engineer use only",

                          textAlign: TextAlign.right,

                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),



                        ),




                        SizedBox(height: 50),


                          TextFormField(


                            decoration: InputDecoration(

                              labelText: "Engineer",

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8))),

                            ),

                            controller: engineerNameController,


                          ),


                    SizedBox(height: 50),


                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(

                          labelText: "Work Status",

                        border: OutlineInputBorder(),
                      ),
                      hint: const Text("Please Select"),

                      value: work,

                      onChanged: (String? newValue) {
                        setState(() {
                          work = newValue??"";
                        });
                      },


                      items: <String> ["Assigned","Submitted","Waiting on shop response","Complete"].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),


                      ),



                        SizedBox(height: 50),

                        TextFormField(


                          decoration: InputDecoration(

                            labelText: "Estimated Engineering Time(Hours)",

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8))),

                          ),

                          controller: workTimeController,



                        ),


                        SizedBox(height: 50),

                        TextField(

                          decoration: InputDecoration(

                            labelText: "Final Remarks",

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8))),

                          ),

                          maxLines: 4,

                          controller: remarkController,

                        ),


                        SizedBox(height: 50),


                        ElevatedButton(

                          onPressed: () async{


                            EngineerWork  engineerWork = EngineerWork(userId: id, engineerName: engineerNameController.text, workStatus: work, workTime: workTimeController.text, remarks:remarkController.text);


                            Provider.of<Inquiry>(context,listen: false).addEngineerWorkItem("token", "network", engineerWork);

                          }, child: Text("Submit"),
                        ),






                      ],





                    ),

                  ),
                ),
              ],
            ),

          ),
              ),
      );


















        }



}