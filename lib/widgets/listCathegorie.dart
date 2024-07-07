import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadith_app/hadith/cathegories.dart';
import 'package:hadith_app/widgets/favorite.dart';

import 'package:hadith_app/widgets/listHadith.dart';
import 'package:hadith_app/widgets/settings.dart';

class ListCathegorie extends StatefulWidget {
  const ListCathegorie({super.key});
  

  @override
  State<ListCathegorie> createState() => _ListCathegorieState();
}

class _ListCathegorieState extends State<ListCathegorie> {
  List<Cathegorie> cathegories = [];
  List <Cathegorie> subCathegories = [];
  String search = "";
  bool isload = true;
  @override
  void initState() {
     super.initState();

    getCathegories()!.listen((event) {

      setState(() {
        cathegories = parseCathegories(event);
        isload = false;
        //subCathegories = cathegories;
      });
    });
  }
   
   
  @override
  void dipsose(){
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          leadingWidth: 100,
          leading: Expanded(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
                  },
                  icon:
                      const Icon(Icons.settings, size: 30, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritePage()));
                  },
                  icon: const Icon(Icons.favorite, size: 30, color: Colors.red),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.grey[600],
          title: Container(
            margin:const EdgeInsets.only(left: 10, right: 10),
            child: CupertinoTextField(
              textDirection: TextDirection.rtl,

              prefix: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(CupertinoIcons.search),
              ),
            placeholder: "Search",
              onChanged: (value){
              
                setState(() {
                  search = value;
                  subCathegories = cathegories.where((element) => element.title.contains(value)).toList();
                });
              
              },
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        body:
        isload ? const Center(child: CircularProgressIndicator(),) :
         search.isNotEmpty && subCathegories.isEmpty ? const Center(child: Text("No results found"),) :
        ListView.builder(
          itemCount: subCathegories.isNotEmpty ? subCathegories.length : cathegories.length,
          
          itemBuilder: (context, index) {
           
          

            
                //parse the json
                final category = subCathegories.isNotEmpty  ? subCathegories[index] :  cathegories[index];

                return Column(
                  children: [
                   
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        key: Key(category.id),
                        title: Text(
                          "العنوان : " + category.title,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "عدد الأحاديث : " + category.hadeeths_count,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.bold),
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
