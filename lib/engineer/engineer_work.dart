class EngineerWork
{

  late String id;

  late String userId;

  late String engineerName;

   String ? workStatus;

  late String workTime;

  late String remarks;

  EngineerWork({

    required this.userId,

    required this.engineerName,

    required this.workStatus,

    required this.workTime,


    required this.remarks



});



  EngineerWork.fromJson(Map<String, dynamic> json) {

    id = json["id"];

    userId = json["userId"];


    engineerName = json["engineerName"];


    workStatus = json["workStatus"];

    workTime = json["workTime"];

    remarks = json["remarks"];



    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();


      data["id"] = this.id;


      data["userId"] = this.userId;


      data["engineerName"] = this.engineerName;


      data["workStatus"] = this.workStatus;


      data["workTime"] = this.workTime;


      data["remarks"] = this.remarks;


      return data;
    }

  }







}