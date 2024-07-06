import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadith_app/hadith/cathegories.dart';
import 'dart:convert';

import 'package:hadith_app/widgets/listHadith.dart';

class ListCathegorie extends StatefulWidget {
  const ListCathegorie({super.key});

  @override
  State<ListCathegorie> createState() => _ListCathegorieState();
}

class _ListCathegorieState extends State<ListCathegorie> {
  List<Cathegorie> cathegories = [];
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
                  onPressed: () {},
                  icon:
                      const Icon(Icons.settings, size: 30, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite, size: 30, color: Colors.red),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.grey[600],
          title: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: CupertinoTextField(
              prefix: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(CupertinoIcons.search),
              ),
              placeholder: "Search",
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        body: StreamBuilder(
          stream: getCathegories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }
            print(snapshot.data);

            cathegories = parseCathegories(snapshot.data);

            return ListView.builder(
              itemCount: cathegories.length,
              itemBuilder: (context, index) {
                //parse the json
                final category = cathegories[index];

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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Listhadith(id:category.id ),));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                );
              },
            );
          },
        ));
  }
}
