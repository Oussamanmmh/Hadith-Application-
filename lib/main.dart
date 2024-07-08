import 'package:flutter/material.dart';
import 'package:hadith_app/options/mode.dart';
import 'package:hadith_app/widgets/landingpage.dart';
import 'package:hadith_app/widgets/listCathegorie.dart';
import 'package:hadith_app/widgets/modeModel.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('hadith_favorite');
  await Hive.openBox('mode');
  runApp(
    MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ModeModel()),
    ],
    child: const MyApp()
    )
  );


}

class MyApp extends StatelessWidget {
  const MyApp({super.key });
   
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     dynamic mode = Hive.box('mode').get('mode'); 

   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: mode == 'light' ? ThemeData.light() : ThemeData.dark(),
      routes: {
        '/listCathegorie': (context) => const ListCathegorie(),
      },
      home: const LandingPage(),
    );
  }
}

