class CheckBox{

   late String id;

   late String value;

   CheckBox({

     required this.id,

     required this.value
});



   CheckBox.fromJson(Map<String, dynamic> json) {
     id = json['id'];
     value = json['value'];

   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['id'] = this.id;
     data['value'] = this.value;


     return data;
   }

}