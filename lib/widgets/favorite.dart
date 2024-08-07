

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadith_app/hadith/hadith.dart';
import 'package:hadith_app/hadith/hadithdetails.dart';
import 'package:hadith_app/options/languages.dart';
import 'package:hadith_app/widgets/detailsHadith.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final hadith_favorite = Hive.box('hadith_favorite');
  bool isload = true;
  late String lang ;
  final List<dynamic> selectedHadeeth = [];


  @override
  void initState() {
    super.initState();
    print("jdisj");
   
   lang = Provider.of<LanguageModel>(context, listen: false).getLanguage;

    for (var i = 0; i < hadith_favorite.length; i++) {
      print(hadith_favorite.getAt(i));
      getHadithDetails(hadith_favorite.getAt(i), lang).listen((event) {
        setState(() {
          selectedHadeeth.add(parseHadithDetails(event));
          isload = false;
        });
      });
    }
    if (hadith_favorite.isEmpty) {
      setState(() {
        isload = false;
      });
    }
   
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:   Theme.of(context).colorScheme.background,
      appBar: AppBar(
       // titleTextStyle:TextStyle(color: Colors.black),
        toolbarHeight: 90,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:  Icon(Icons.arrow_back ,color: Theme.of(context).colorScheme.onSecondary,),
        ),
        title: const Text("Favorite" ),
      ),
      body: selectedHadeeth.isEmpty ? Center(
        child:isload ? const CircularProgressIndicator(): Text("No favorite hadith yet!", style: TextStyle(fontWeight: FontWeight.bold),),
      ): ListView.builder(
        itemCount: selectedHadeeth.length,
        itemBuilder: (context, index) {
          return Container(
            key: Key(selectedHadeeth[index].id),
              margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                 
                 
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondary,
                ),
            child: ListTile(
              key: Key(selectedHadeeth[index].id),
              title: Text("حديث : "+ selectedHadeeth[index].title , textDirection: TextDirection.rtl,style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    setState(() {
                      print("localstorage:");
                       print(hadith_favorite.getAt(index)) ;
                      hadith_favorite.delete(selectedHadeeth[index].id);
                     
                      selectedHadeeth.removeAt(index);
                    });
                  }, 
                  icon:  Icon(Icons.favorite, color: Colors.red,)), 

                      Text("الرقم : "+selectedHadeeth[index].id ,textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsHadith(id: selectedHadeeth[index].id, lang: lang,),
                  ),
                );
              },
            ),
          );
        },
      )
    );
  }
}