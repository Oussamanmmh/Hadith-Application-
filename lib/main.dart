import 'package:flutter/material.dart';
import 'package:hadith_app/widgets/landingpage.dart';
import 'package:hadith_app/widgets/listCathegorie.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


void main() async{
  await Hive.initFlutter();
  await Hive.openBox('hadith_favorite');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
   
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
         primaryColor: Colors.deepPurple,
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/listCathegorie': (context) => const ListCathegorie(),
      },
      home: const LandingPage(),
    );
  }
}

