
class Item {


  late String id;

  late String carMark;

  late String carNumber;

  late String shop;

  late String priority;

  late String submittedBy;

  late String ? relevantDrawings;

  late String ? questions;

  late String carStatus;

  late List<dynamic>?checkList;

  late String ? file;

  late String ? isDeleted;

  late String ? action;

  Item({

    required this.carMark,

    required this.carNumber,

    required this.carStatus,

    required this.submittedBy,

    required this.questions,

    required this.priority,

    required this.shop,

    required this.relevantDrawings,

    required this.checkList,


  });


  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carMark = json['carMark'];
    carNumber = json['carNumber'];
    carStatus = json['carStatus'];
    submittedBy = json['submittedBy'];
    priority = json['priority'];
    shop = json['shop'];
    relevantDrawings = json['relevantDrawings'];
    questions = json['questions'];
    checkList = json['checkList'] == null ? null:json['checkList'];
    file = json['file'] == null ? null : json['file'];
    isDeleted = json['isDeleted'] == null ? null : json['isDeleted'];
  }

// exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carMark'] = this.carMark;
    data['carNumber'] = this.carNumber;
    data['carStatus'] = this.carStatus;
    data['submittedBy'] = this.submittedBy;
    data['priority'] = this.priority;
    data['shop'] = this.shop;
    data['relevantDrawings'] = this.relevantDrawings;
    data['questions'] = this.questions;
    data['checklist'] = this.checkList;
    return data;
  }



}