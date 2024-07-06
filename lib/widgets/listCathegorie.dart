import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadith_app/hadith/cathegories.dart';
import 'dart:convert';

class ListCathegorie extends StatelessWidget {
  const ListCathegorie({super.key});

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        
        leading:Expanded(
          child: Row(
            children: [
            IconButton(onPressed: (){},
             icon: const Icon(Icons.settings ,
             size: 30,
             color: Colors.white),
            ),
            IconButton(onPressed: (){},
             icon: const Icon(Icons.favorite ,
             size: 30,
             color: Colors.red),
            ),
           
            ],
          
          ),
        ),
        backgroundColor: Colors.grey[600],
        title: const Center(
          child: Text("Hadith App"),
        ),
        
      ),
      body: Column(
      
        children: [
          SizedBox(height: 20,),       
             Container(
              margin: EdgeInsets.only(left: 10 , right: 10),
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
           SizedBox(height: 20,),
          Expanded(
            child: StreamBuilder(
              stream: getCathegories(),
              builder:(context , snapshot){
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
                print(snapshot.data);
          
                final cathegories = parseCathegories(snapshot.data);
          
                return ListView.builder(
                  itemCount: cathegories.length,
                  itemBuilder: (context , index){
                    print("the count is ${snapshot.data.length}");
                    //parse the json 
                    final category = cathegories[index];
                    
          
                    return Column(
                      children: [
                        Container(
                          
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
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
                          
                        
                            title: Text(category.title),
                            subtitle: Text(category.hadeeths_count),
                            onTap: (){},
                        
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    );
                    
                  },
                );
              } ,
            ),
          ),
        ],
      )
    );
  }
}