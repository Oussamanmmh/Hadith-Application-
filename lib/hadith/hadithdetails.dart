import 'dart:convert';
import 'package:http/http.dart' as http;

class HadithDetails {
  final String id;
  final String title;
  final String hadeeth;
  final String grade;
  final String attribution;
  final String explanation;
  final List <dynamic> hints;
  final String reference;
  HadithDetails({
    required this.grade,
    required this.id,
    required this.title,
    required this.hadeeth,
    required this.attribution,
    required this.explanation,
    required this.hints,
    required this.reference,
  });
  factory HadithDetails.fromJson(Map<String, dynamic> json) {
    return HadithDetails(
      id: json['id'],
      grade: json['grade'],
      title: json['title'],
      hadeeth: json['hadeeth'],
      attribution: json['attribution'],
      explanation: json['explanation'],
      hints: json['hints'],
      reference: json['reference'],
    );
  }
}

Stream<String> getHadithDetails(String id) async* {
  final url =
      "https://hadeethenc.com/api/v1/hadeeths/one/?language=ar&id=${id}";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    yield response.body;
  } else {
    print("Failed to get hadith details");
  }
}

HadithDetails parseHadithDetails(String  responseBody) {

  final  decodedJson = jsonDecode(responseBody) as Map<String, dynamic>;
 print("decodedJson :") ;
  print(decodedJson) ;
  
  return HadithDetails.fromJson(decodedJson);
}
