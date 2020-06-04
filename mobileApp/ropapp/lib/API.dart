/*
Clase la cual nos da acceso al método GetData, 
el cual hace la peticción http a la API que 
hemos creado para hacer el WebScrapping a ASOS
*/
import 'package:http/http.dart' as http;

Future Getdata(url) async {
  http.Response Response = await http.get(url);
  print(Response.body);
  return Response.body;
}