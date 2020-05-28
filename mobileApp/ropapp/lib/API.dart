import 'package:http/http.dart' as http;

Future Getdata(url) async {
  http.Response Response = await http.get(url);
  print(Response.body);
  return Response.body;
}