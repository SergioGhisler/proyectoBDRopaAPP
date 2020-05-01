/*
*  mobile_dark_widget.dart
*  DISEÑO APP
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'dart:io';

import 'package:ropapp/values/values.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'transicion/transition_witget.dart';

class HomeWidget extends StatefulWidget {
  static double phoneWidth=_HomeWidgetState.phoneWidth;
  static double phoneHeight=_HomeWidgetState.phoneWidth;
  static double phoneBlockWidth=_HomeWidgetState.phoneBlockWidth;
  static double phoneBlockHeight=_HomeWidgetState.phoneBlockHeight;
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  
  static double phoneWidth;

  static double phoneHeight;

  static double phoneBlockWidth;

  static double phoneBlockHeight;
  File _image;

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
                        width: phoneBlockWidth*80,
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
                  Spacer(),
                  _image== null?Container():
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        width: 57,
                        height: 57,
                        child: FloatingActionButton(
                          heroTag: 'pasarPagina',
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TransitionWidget()),
                            );
                          },
                          child: Icon(Icons.send),
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
                  fontFamily:'Montserrat', 
                  
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
