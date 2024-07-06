import 'package:flutter/material.dart';
import 'package:hadith_app/hadith/hadith.dart';

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
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        
        }, icon: const Icon(Icons.arrow_back),),
        title: Text("Hadiths"),
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
              return ListTile(
                title: Text(hadiths[index].title),
              );
            },
          );
        },

      )
      );
      

  }
}