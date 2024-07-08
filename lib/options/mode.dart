import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  
colorScheme : const ColorScheme.light(
  background:Color.fromARGB(255, 255, 210, 156),
  primary: Color(0xfffbe5ba),
  secondary: Color(0xfffdf1cb),
  onSecondary: Colors.black,

 
 

) ,
  appBarTheme: const AppBarTheme(
   
    titleTextStyle: TextStyle(color: Colors.black , fontSize: 20),
    
  ),
);

ThemeData darkTheme = ThemeData(
 brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background:Color.fromARGB(255, 0, 0, 0),
    primary: Color(0xff1a1a1a),
    secondary: Color(0xff2b2b2b),
    onSecondary: Colors.white,
  )
);