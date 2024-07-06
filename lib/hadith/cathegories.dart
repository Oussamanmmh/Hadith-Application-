 import 'package:http/http.dart' as http;
 import 'dart:convert';
 //the cathegory class
class Cathegorie{
  final String id ;
  final String title;
  final String hadeeths_count;
  final String ? parent_id ; 

  Cathegorie({
    required this.id,
    required this.title,
    required this.hadeeths_count,
    this.parent_id,
  });
  factory Cathegorie.fromJson(Map<String , dynamic> json){
    return Cathegorie(
      id: json['id'],
      title: json['title'],
      hadeeths_count: json['hadeeths_count'],
      parent_id: json['parent_id'],
    );
  }




}
  


//get the cathegories 
Stream<dynamic>? getCathegories() async* {
    

  
     const url = "https://hadeethenc.com/api/v1/categories/list/?language=ar" ;
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        print(response.body);
        //prarse the json 
        
        yield response.body;
      }
      else{
        print("Failed to get cathegories");
      }

 
}



//parse the json
  List<Cathegorie> parseCathegories(String responseBody){
  final parsed = jsonDecode(responseBody).cast<Map<String , dynamic>>();
  return parsed.map<Cathegorie>((json) => Cathegorie.fromJson(json)).toList();
  }