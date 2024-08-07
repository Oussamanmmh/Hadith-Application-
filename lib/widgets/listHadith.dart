import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadith_app/hadith/hadith.dart';
import 'package:hadith_app/options/languages.dart';
import 'package:hadith_app/widgets/detailsHadith.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class Listhadith extends StatefulWidget {
  const Listhadith({super.key, required this.id});
  final String id;


  @override
  State<Listhadith> createState() => _ListhadithState();
}

class _ListhadithState extends State<Listhadith> {
  bool isFav = false;
  final hadith_favorite = Hive.box('hadith_favorite');
  List<String> selectedId = [];
  bool isload = true;
  List <Hadith> hadiths = [];
  List<Hadith> selectedHadith = [];
  String search = "";
  late String lang ;

  @override
  void initState() {
    super.initState();
    // for (var i = 0; i < hadith_favorite.length; i++) {
    //   selectedId.add(hadith_favorite.getAt(i));
    // }
    // getHadiths(widget.id )!.listen((event) {
    //   setState(() {
    //     hadiths = parseHadiths(event);
    //     selectedHadith = hadiths;
    //     isload = false;
    //   });
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
    lang = Provider.of<LanguageModel>(context, listen: false).getLanguage;
    print("langauages : $lang");
    for (var i = 0; i < hadith_favorite.length; i++) {
      selectedId.add(hadith_favorite.getAt(i));
    }
    getHadiths(widget.id, lang)!.listen((event) {
      setState(() {
        hadiths = parseHadiths(event);
        selectedHadith = hadiths;
        isload = false;
      });
    });
  });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          toolbarHeight: 90,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:  Icon(Icons.arrow_back , color:  Theme.of(context).colorScheme.onSecondary,),
          ),
          title: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: CupertinoTextField(
              prefix: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(CupertinoIcons.search),
              ),
              placeholder: "Search",
              onChanged: (value) {
                setState(() {
                  selectedHadith = hadiths
                      .where((element) => element.title.contains(value))
                      .toList();
                      search = value;
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
        body:isload ? Center( child: CircularProgressIndicator()) :  search.isNotEmpty && selectedHadith.isEmpty ? 
         Center(
              child: Text("No Hadith found for $search"),
            ):
           ListView.builder(
              itemCount:selectedHadith.isNotEmpty ? selectedHadith.length : hadiths.length,
              itemBuilder: (context, index) {
                final hadith = selectedHadith.isNotEmpty ? selectedHadith[index] : hadiths[index];
                return Container(
                  
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                   
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    key: ValueKey<String>(hadith.id),
                    title: Text(
                      "حديث : " + hadith.title,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                            

                              if (selectedId.contains(hadith.id)) {
                                selectedId.remove(hadith.id);

                                hadith_favorite.delete(hadith.id);
                              } else {
                                selectedId.add(hadith.id);

                                hadith_favorite.put(
                                    hadith.id, hadith.id);
                              }
                            });
                          },
                          icon: Icon(Icons.favorite),
                          color: selectedId!.contains(hadith.id)
                              ? Colors.red
                              : Colors.grey,
                        ),
                        Text(
                          "الرقم : " + hadith.id,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onTap: () {
                      //navigate to the hadith page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsHadith(
                                    id: hadith.id,
                                    lang: lang 
                                  )));
                    },
                  ),
                );
              },
            )
          
        );
  }
}
