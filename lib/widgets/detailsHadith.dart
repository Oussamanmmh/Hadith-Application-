

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hadith_app/hadith/hadithdetails.dart';

class DetailsHadith extends StatelessWidget {
  const DetailsHadith({Key? key, required this.id});
  final String id; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Details Hadith"),
      ),
      body: Center(
        child: StreamBuilder(
        stream: getHadithDetails(id), 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            return const Center(
              child: Text("Error"),
            );
          }
          

         final HadithDetails hadithDetails = HadithDetails.fromJson(jsonDecode(snapshot.data!));
         
          
          return ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15,),
                child: Column(
                  
                  children: [
                    Text(hadithDetails.title,textAlign: TextAlign.center,textDirection:TextDirection.rtl, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Text(hadithDetails.hadeeth,textDirection:TextDirection.rtl ,textAlign: TextAlign.right, style: TextStyle(fontSize: 18),),
                    const SizedBox(height: 10,),
                    Text(hadithDetails.attribution,textAlign: TextAlign.left, style: TextStyle(fontSize: 15),),
                   
                  ],
                ),
              ),
            ],
          );
        },
      ),
      ),
    );
  }
}