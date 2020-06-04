/*
Clase la cual la cual representa las recomendaciones de prendas 
similares predichas por el modelo. Muestra modelos diferentes para 
cada prenda, con el color correspondiente predicho por el modelo y 
el precio correspondiente. Cuando pulsas encima de una de las prendas, 
dirige a la clase infoItem_widget.dart, dónde nos mostrará la prenda 
en detalle, más imágenes de la prenda en cuestión y dónde se podrá 
redirigir a la página de ASOS para realizar la compra.
*/


import 'dart:io';
import 'package:collection/collection.dart';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ropapp/home_widget.dart';
import 'package:ropapp/infoItem_Widget.dart';
import 'package:ropapp/values/colors.dart';
import 'package:tflite/tflite.dart';
import 'colorsPred.dart';
import 'package:ropapp/API.dart';
import 'package:ropapp/item.dart';



class AllItems extends StatefulWidget {
  final File photo;
  final String sex;
  final bool isAndroid;

  const AllItems({this.photo, this.sex,this.isAndroid});

  @override
  _AllItemsState createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  bool _busy = false;
  int _ropaLen;
  double _imageWidth;
  double _imageHeight;
  List _recognitions;
  String res;
  List<File> imagenesPartidas;
  List _resul;
  List<List> _colorRecog;
  int contador = 0;
  int _contadorAux = 0;

  List scrape = new List();
  List predicfinal = new List();
  String _sex = "women";

  void initState() {
    super.initState();
    _busy = true;

    predictImage();
  }

  Future predictImage() async {
    FileImage(widget.photo)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
          });
        })));

    try {
      res = await Tflite.loadModel(
        model: "assets/model/ropaModel.tflite",
        labels: "assets/model/ropaLabels.txt",
      );
      print(res);
    } on PlatformException {
      print('Failed to load model');
    }
    print(widget.photo.path);
    var recognitions = await Tflite.detectObjectOnImage(
      path: widget.photo.path,
      threshold: 0.35,
    );

    print(recognitions);
    print(_imageHeight);
    print(_imageWidth);
    setState(() {
      _ropaLen = recognitions.length;
      _recognitions = recognitions;
      color();
    });
  }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];
    double factorX;
    double factorY;

    if (_imageWidth < screen.width) {
      factorX = _imageWidth;
      factorY = _imageHeight;
    } else {
      double proportion = _imageWidth / screen.width;
      factorX = screen.width;
      factorY = _imageHeight / proportion;
      print('hola');
    }

    return _recognitions?.map((re) {
          return Positioned(
            left: re["rect"]["x"] * factorX,
            top: re["rect"]["y"] * factorY,
            width: re["rect"]["w"] * factorX,
            height: re["rect"]["h"] * factorY,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.blue,
                width: 3,
              )),
              child: Text(
                "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  background: Paint()..color = Colors.blue,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          );
        })?.toList() ??
        [];
  }

  List<Widget> result() {
    if (scrape.length == 0) return [];
    if (_recognitions != null &&
        _colorRecog != null &&
        imagenesPartidas != null) {
      setState(() {
        _resul = IterableZip([_recognitions, _colorRecog, imagenesPartidas])
                ?.map((re) {
              return Column(children: <Widget>[
                Image.file(re[2]),
                Text(
                  "${re[0]["detectedClass"]}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    " ${(re[0]["confidenceInClass"] * 100).toStringAsFixed(0)}% ${(re[0]["rect"])}"),
                Text(
                  "${re[1][0]["label"]}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(" ${(re[1][0]["confidence"] * 100).toStringAsFixed(0)}%"),
              ]);
            })?.toList() ??
            [];
      });
    }
    setState(() {
      _busy = false;
    });

    return _resul;
  }

  void conectApi(url) async {
    bool aux =true;
    if(_recognitions.length==scrape.length) return;
    while (aux ) {
      String Data;
      if (widget.isAndroid) {
        Data = await Getdata(
            "http://10.0.2.2:5000/api?Query=" + url + " " + widget.sex);
      } else {
        Data = await Getdata(
            "http://127.0.0.1:5000/api?Query=" + url + " " + widget.sex);
      }
      String Datos = Data;
      setState(() {
        try{
          scrape.add(convert.jsonDecode(Data));   
          aux=false;
           predicfinal.add(url);
        }catch (e)  {
          print('repetimos');
        }
    
       
      });
    }
  }

  Future<void> color() async {
    List<File> auxlist = new List();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    colorPred(widget.photo, _recognitions, _imageWidth, _imageHeight);

    for (int i = 0; i < _recognitions.length; i++) {
      auxlist.add(new File(appDocPath + "/image" + i.toString() + ".png"));
      var colorRecog = await Tflite.detectObjectOnImage(
        path: auxlist[i].path,
      );
      print(colorRecog);
    }

    setState(() {
      imagenesPartidas = auxlist;
    });
    predecirColor();
  }

  Future predecirColor() async {
    List<List> colorRecog = new List();
    try {
      res = await Tflite.loadModel(
        model: "assets/model/colores.tflite",
        labels: "assets/model/coloresLabels.txt",
      );
      print(res);
    } on PlatformException {
      print('Failed to load model');
    }
    for (int i = 0; i < _recognitions.length; i++) {
      print(imagenesPartidas[i].path);
      colorRecog.add(await Tflite.runModelOnImage(
        imageMean: 127.5, // defaults to 127.5
        imageStd: 70.5,
        numResults: 10, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true, // defaults to true

        path: imagenesPartidas[i].path,
      ));

      print(colorRecog);
      String aux =
          colorRecog[i][0]["label"] + " " + _recognitions[i]["detectedClass"];

      print(aux);
      conectApi(aux);
    }
    for (int i = 0; i < scrape.length; i++) {
      print(scrape[i]);
    }

    setState(() {
      _colorRecog = colorRecog;
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];
    stackChildren.add(
      Image.file(
        widget.photo,
      ),
    );

    stackChildren.addAll(renderBoxes(size));
    List<Widget> resulta = [];

    resulta.addAll(result());
    return Scaffold(
      body: _busy
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
              ),
            )
          : Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
              ),
              child: ListView(
                children: [
                  Container(
                    width: HomeWidget.phoneWidth,
                    height: HomeWidget.phoneBlockHeight * 20,
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/images/logoRopapp.png",
                      ),
                    ),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: scrape.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              height: 10,
                            ),
                            Container(
                              height: HomeWidget.phoneBlockHeight * 30,
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Card(
                                color: AppColors.primaryElement,
                                elevation: 66,
                                child: Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          predicfinal[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.primaryText,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ...(scrape[index]["items"])
                                                .map((item) {
                                              return Item(
                                                  item['photo'],
                                                  item['precio'],
                                                  () =>
                                                      lookItem(context, item));
                                            }).toList(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      })
                ],
              ),
            ),
    );
  }

  void lookItem(context, item) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InfoWidget(
              text: item['nombre'],
              images: item["todas las fotos"],
              link: item["link"]),
        ));
  }
}
