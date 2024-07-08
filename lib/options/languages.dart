import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class LanguageModel extends ChangeNotifier{
  dynamic select = Hive.box('language').get('language');
  dynamic get getLanguage => select ;
  int get getSelect => select == 'en' ? 0 : select == 'ar' ? 1 : 2;
  void changeLanguage(int value){
     switch (value) {
     case 0:
       select = 'en';
       break;
     case 1:
       select = 'ar';
       break;
     case 2:
       select = 'fr';
       break;
     default:
    Hive.box('language').put('language', select);
    notifyListeners();
  }

  

  }
}