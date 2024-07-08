import 'dart:convert';
import 'package:http/http.dart' as http;
class Hadith {
 final String id ;
final String title;


Hadith({
  required this.id,
  required this.title,
});

factory Hadith.fromJson(Map<String , dynamic> json){
  return Hadith(
    id: json['id'],
    title: json['title'],
  );
}

}

Stream<dynamic>? getHadiths(String id , String lang) async* {
  print("id: $id");
  final url = "https://hadeethenc.com/api/v1/hadeeths/list/?language=${lang}&category_id=${id}&page=1&per_page=20";
  final response = await http.get(Uri.parse(url));
  if(response.statusCode == 200){
    
    yield response.body;
  }
  else{
    print("Failed to get hadiths");
  }
}

List<Hadith> parseHadiths(String responseBody) {
 
  final Map<String, dynamic> decodedJson = jsonDecode(responseBody);
  // Assuming the list of hadiths is under a key 'data'. Adjust if your structure is different.
  final List<dynamic> hadithsList = decodedJson['data'];
  return hadithsList.map<Hadith>((json) => Hadith.fromJson(json)).toList();

}