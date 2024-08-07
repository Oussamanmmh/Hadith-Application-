import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadith_app/hadith/cathegories.dart';
import 'package:hadith_app/options/languages.dart';
import 'package:hadith_app/widgets/favorite.dart';

import 'package:hadith_app/widgets/listHadith.dart';
import 'package:hadith_app/widgets/settings.dart';
import 'package:provider/provider.dart';

class ListCathegorie extends StatefulWidget {
  const ListCathegorie({super.key});

  @override
  State<ListCathegorie> createState() => _ListCathegorieState();
}

class _ListCathegorieState extends State<ListCathegorie> {
  List<Cathegorie> cathegories = [];
  List<Cathegorie> subCathegories = [];
  String search = "";
  bool isload = true;
  late var lang  ;
  @override
  void initState() {
    super.initState();
    print("init state");
    print(Provider.of<LanguageModel>(context, listen: false).getLanguage);

    Provider.of<LanguageModel>(context, listen: false).addListener(() {
      setState(() {
        lang = Provider.of<LanguageModel>(context, listen: false).getLanguage;
          getCathegories(lang)!.listen((event) {
      setState(() {
        cathegories = parseCathegories(event);
        isload = false;
        //subCathegories = cathegories;
      });
    });
        
      });
    });
     
 lang = Provider.of<LanguageModel>(context, listen: false).getLanguage;
    getCathegories(lang)!.listen((event) {
      setState(() {
        cathegories = parseCathegories(event);
        isload = false;
        //subCathegories = cathegories;
      });
    });
  }

  @override
  void dipsose() {
    super.dispose();
    Provider.of<LanguageModel>(context, listen: false).removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          toolbarHeight: 90,
          leadingWidth: 100,
          leading: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                },
                icon: Icon(
                  Icons.settings,
                  size: 30,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoritePage()));
                },
                icon: const Icon(Icons.favorite,
                    size: 30, color: Color.fromARGB(255, 190, 17, 5)),
              ),
            ],
          ),
          title: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: CupertinoTextField(
                key: const Key("search") ,
                textInputAction: TextInputAction.search,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              textDirection: TextDirection.rtl,
              prefix: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(CupertinoIcons.search),
              ),
              placeholder: "Search",
              onChanged: (value) {
                setState(() {
                  search = value;
                  subCathegories = cathegories
                      .where((element) => element.title.contains(value))
                      .toList();
                });
              },
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        body: isload
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : search.isNotEmpty && subCathegories.isEmpty
                ? const Center(
                    child: Text("No results found"),
                  )
                : ListView.builder(
                    itemCount: subCathegories.isNotEmpty
                        ? subCathegories.length
                        : cathegories.length,
                    itemBuilder: (context, index) {
                      //parse the json
                      final category = subCathegories.isNotEmpty
                          ? subCathegories[index]
                          : cathegories[index];

                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              //background color #758694

                              color: Theme.of(context).colorScheme.secondary,

                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              key: Key(category.id),
                              title: Text(
                                "العنوان : " + category.title,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "عدد الأحاديث : " + category.hadeeths_count,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Listhadith(id: category.id),
                                    ));
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    },
                  ));
  }
}
