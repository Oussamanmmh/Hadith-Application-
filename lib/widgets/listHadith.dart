import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadith_app/hadith/hadith.dart';
import 'package:hadith_app/widgets/detailsHadith.dart';

class Listhadith extends StatefulWidget {
  const Listhadith({super.key , required this.id});
  final String id;

  @override
  State<Listhadith> createState() => _ListhadithState();
}

class _ListhadithState extends State<Listhadith> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        
        }, icon: const Icon(Icons.arrow_back),),
        title:  Container(
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
        stream: getHadiths(widget.id),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final hadiths = parseHadiths(snapshot.data);
          return ListView.builder(
            itemCount: hadiths.length,
            itemBuilder: (context , index){
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
                  title: Text("حديث : "+hadiths[index].title ,textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border) , color: Colors.red,),
                      Text("الرقم : "+hadiths[index].id ,textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  onTap: (){
                    //navigate to the hadith page
                    Navigator.push(context, MaterialPageRoute(builder: 
                    (context) => DetailsHadith(id: hadiths[index].id,)));
                  },
                ),
              );
            },
          );
        },

      )
      );
      

  }
}