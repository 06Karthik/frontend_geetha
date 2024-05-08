import 'package:flutter/material.dart';

import '../facade/inquiryList.dart';

class Torque extends DataTableSource {

  late var _data ;

  late BuildContext _context;

  Torque(InquiryList inquiryList,BuildContext context){

    _data = inquiryList.inquiryList;

    _context = context;

  }
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Center(child:Text(_data[index].carMark))),
      DataCell(Center(child:Text(_data[index].carNumber))),
      DataCell(Center(child:Text(_data[index].carStatus))),
      DataCell(Center(child:Text(_data[index].priority))),
      DataCell(Center(child:Text(_data[index].shop))),
      DataCell(Center(child:Text(_data[index].submittedBy))),
      DataCell(Center(child: OutlinedButton.icon(onPressed: () {

        String id =  _data[index].id;
        Navigator.of(_context).pushNamed("/engineer_inquiry",arguments: {"id":id});

       print("EDIT "+id);

        },icon:const Icon(Icons.edit,color:Colors.grey),style: OutlinedButton.styleFrom(
    side: BorderSide(width: 1.0, color: Colors.grey),
    ), label:const Text("EDIT",style: TextStyle(color: Colors.grey,fontSize: 10))))




      ),



    ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}