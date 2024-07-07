import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadith_app/hadith/hadith.dart';
import 'package:hadith_app/hadith/hadithdetails.dart';
import 'package:hadith_app/widgets/detailsHadith.dart';
import 'package:hive/hive.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final hadith_favorite = Hive.box('hadith_favorite');
  final List<dynamic> selectedHadeeth = [];


  @override
  void initState() {
    super.initState();
    print("jdisj");
    for (var i = 0; i < hadith_favorite.length; i++) {
      print(hadith_favorite.getAt(i));
      getHadithDetails(hadith_favorite.getAt(i)).listen((event) {
        setState(() {
          selectedHadeeth.add(parseHadithDetails(event));
        });
      });
    }
   
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Favorite"),
      ),
      body: ListView.builder(
        itemCount: selectedHadeeth.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: const[ BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),],
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
            child: ListTile(
              title: Text(selectedHadeeth[index].title),
              subtitle: Text(selectedHadeeth[index].hadeeth),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsHadith(id: selectedHadeeth[index].id),
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