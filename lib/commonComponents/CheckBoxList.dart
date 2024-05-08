

import 'CheckBox.dart';

class CheckBoxList {


  late List<CheckBox> _checkBoxes;



  CheckBoxList(List<CheckBox> checkBoxes){
    _checkBoxes = checkBoxes;
  }


  List<CheckBox> get boxList => _checkBoxes;

  set boxList(List<CheckBox> checkBoxes) => _checkBoxes = checkBoxes;

  CheckBoxList.fromJson(Map<String, dynamic> json) {

    _checkBoxes = json['results'].map<CheckBox> ((data) =>
       CheckBox.fromJson(data)).toList ();
    print(_checkBoxes);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkBoxList'] = _checkBoxes.map ((item) => item.toJson ()).toList ();

    return data;
  }

}
