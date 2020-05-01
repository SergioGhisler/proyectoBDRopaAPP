import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Prueba extends StatefulWidget {
  @override
  _PruebaState createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
  String url = "https://api.jsonbin.io/b/5ea6de7598b3d53752356697/8";
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    List data;
    var extractData= json.decode(response.body);
     data= extractData["items"][0]["navy trousers"];
     
      print(data[0]["link"]);

      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: new RaisedButton(
      child: new Text('Make request'),
      onPressed: makeRequest,
    ),
        ));
  }
}
