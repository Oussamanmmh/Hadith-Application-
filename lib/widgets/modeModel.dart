import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class ModeModel extends ChangeNotifier{
  bool mode = Hive.box('mode').get('mode') == 'light' ? true : false;


  dynamic get getmode => mode ;

  void changeMode(){
    mode = !mode ;
    Hive.box('mode').put('mode', mode ? 'light' : 'dark');
    notifyListeners();
  }



}