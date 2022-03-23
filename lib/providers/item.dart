import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item extends ChangeNotifier {
  //initializing active button to 'all'
  String _activeButton = "all";

 //get the value of active button
  String get getActiveButton => _activeButton;

 //set active button to be 'all'
  void setActiveAll() {
    _activeButton = "all";

    notifyListeners();
  }
//set active button to be 'product'
  void setActiveProduct() {
    _activeButton = "product";

    notifyListeners();
  }

//set active button to be 'service'  
void setActiveService() {
  _activeButton = "service";

  notifyListeners();
}

}
