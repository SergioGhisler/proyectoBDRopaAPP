import 'package:ropapp/home_widget.dart';

import 'package:flutter/material.dart';


/*
Clase main, la cual nos lleva al HomeWidget(pantalla principal)
*/
void main() => runApp(App());


class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      
      home: HomeWidget(),
    );
  }
}