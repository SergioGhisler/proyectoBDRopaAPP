
/*
Clase que representa la pantalla inicial de la aplicación, en la 
que se muestra el logo de RopApp, y en la que se encuentra un 
mensaje dicindo que se está esperando la imagen. Asimismo, hay 
2 botones que nos permiten subir una imagen para que se busque ropa 
similar a la que aparezca, el tercer botón está inhabilitado. Una 
vez esté la foto, se va a habilitar el tercer botón, en este caso,
un speedDial, (al pulsarlo se nos despliegan dos nuevos botones), que nos permite 
elegir si buscamos ropa de hombre o de mujer, y tras dar a una 
de las dos opciones, nos dirigirá a la clase allItems_widget.dart
*/


import 'dart:io';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ropapp/values/custom_icons_icons.dart';
import 'package:ropapp/values/values.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ropapp/allItems_widget.dart';

class HomeWidget extends StatefulWidget {
  static double phoneWidth = _HomeWidgetState.phoneWidth;
  static double phoneHeight = _HomeWidgetState.phoneWidth;
  static double phoneBlockWidth = _HomeWidgetState.phoneBlockWidth;
  static double phoneBlockHeight = _HomeWidgetState.phoneBlockHeight;
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  static double phoneWidth;

  static double phoneHeight;

  static double phoneBlockWidth;

  static double phoneBlockHeight;
  File _image;

  bool android =Platform.isAndroid;

  @override
  Widget build(BuildContext context) {
    phoneWidth = MediaQuery.of(context).size.width;
    phoneHeight = MediaQuery.of(context).size.height;
    phoneBlockWidth = phoneWidth / 100;
    phoneBlockHeight = phoneHeight / 100;
    Future imageSelectorCamera() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
      });
    }

    Future imageSelectorGalery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }

    return Scaffold(
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat ,
      floatingActionButton: _image == null
          ?  SpeedDial(
            marginRight: phoneBlockWidth*46.5,
            backgroundColor: Colors.grey,
            marginBottom: phoneBlockHeight*5,
              animatedIcon: AnimatedIcons.search_ellipsis,
              animatedIconTheme: IconThemeData(size: phoneBlockWidth*5),
              visible: true,
              curve: Curves.bounceIn
            )
          : SpeedDial(
            marginRight: phoneBlockWidth*46.5,
            marginBottom: phoneBlockHeight*5,
              animatedIcon: AnimatedIcons.search_ellipsis,
              animatedIconTheme: IconThemeData(size: phoneBlockWidth*5),
              visible: true,
              curve: Curves.bounceIn,
              children: [
                // FAB 1
                SpeedDialChild(
                    child: Icon(CustomIcons.female),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            //builder: (context) => TransitionWidget()),
                            builder: (context) => AllItems(
                                  photo: _image,
                                  sex: "women",
                                  isAndroid: android,
                                )),
                      );
                    },
                    label: 'Mujer',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16.0),
                    labelBackgroundColor: Colors.blue),
                // FAB 2

                SpeedDialChild(
                    child: Icon(CustomIcons.male),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            //builder: (context) => TransitionWidget()),
                            builder: (context) => AllItems(
                                  photo: _image,
                                  sex: "men",
                                  isAndroid: android,
                                )),
                      );
                    },
                    label: 'Hombre',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16.0),
                    labelBackgroundColor: Colors.blue)
              ],
            ),

      /* FloatingActionButton(
                          heroTag: 'pasarPagina',
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  //builder: (context) => TransitionWidget()),
                                  builder: (context) => PruebasTF(photo:_image)),
                            );
                          },
                          child: Icon(Icons.send),
                        )),*/

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          brightness: Brightness.dark,
          backgroundColor: AppColors.primaryBackground,
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Center(
                child: Container(
                  width: phoneWidth,
                  height: phoneBlockHeight * 30,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logoRopapp.png",
                        width: phoneBlockWidth * 80,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: phoneBlockHeight * 40,
              child: displaySelectedFile(_image),
            ),
            Container(
              height: phoneBlockHeight * 10,
              margin: EdgeInsets.only(
                  left: phoneBlockWidth * 18,
                  top: phoneBlockHeight * 5,
                  right: phoneBlockWidth * 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        width: 57,
                        height: 57,
                        child: FloatingActionButton(
                          heroTag: "btn1",
                          onPressed: imageSelectorCamera,
                          child: Icon(Icons.photo_camera),
                        )),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        width: 57,
                        height: 57,
                        child: FloatingActionButton(
                          heroTag: "btn2",
                          onPressed: imageSelectorGalery,
                          child: Icon(Icons.photo_library),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget displaySelectedFile(File file) {
    return new Align(
      alignment: Alignment.center,
//child: new Card(child: new Text(''+galleryFile.toString())),
//child: new Image.file(galleryFile),
      child: file == null
          ? Container(
              margin: EdgeInsets.only(
                left: phoneBlockWidth * 10,
                right: phoneBlockWidth * 10,
              ),
              child: new Text(
                '👀\nEsperando imagen',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: new Image.file(
                file,
              ),
            ),
    );
  }
}
