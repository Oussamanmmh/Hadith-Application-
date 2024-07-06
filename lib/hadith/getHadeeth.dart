import 'package:http/http.dart';
Future <void>  getHadeeth ()
async {
  
  const  url = "https://hadeethenc.com/api/v1/categories/list/?language=ar/";
  var response = await Uri.https(url, 'categories/list/?language=ar');

}