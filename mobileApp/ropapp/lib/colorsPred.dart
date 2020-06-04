/*
Clase que contiene el metodo colorPred, esta clase hace  el 
procesado de la imágen (cortar la imagen en los distintos trozos,
decodificar la imagen para ponerla en el formato correcto...).

El método color pred, pide:
img->Imagen completa que queremos procesar.
recognition-> Lista con los distintos puntos que hemos predicho que 
seran los que debemos de marcar como límites de nuestra imagen.
_imageWidth-> Ancho de la imágen, lo cual se utilizara para que 
el problema se pueda adaptar a cualquier tamaño de imágen.
_imageHeight-> Ancho de la imágen, lo cual se utilizara para que 
el problema se pueda adaptar a cualquier tamaño de imágen.
*/
import 'package:image/image.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
  


  void colorPred(File img, List recognition, double _imageWidth , double _imageHeight)  async {

    Image image = decodeJpg(img.readAsBytesSync());
    
      double factorX = _imageWidth;
      double factorY = _imageHeight;
  
      int contador=0;
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
    for (var i in recognition){
  
        var left= (i["rect"]["x"] * factorX).round();
        print(left);
        var top = (i["rect"]["y"] * factorY).round();
        print(top);
        
        var width = (i["rect"]["w"] * factorX).round();
        print(width);
        var height = (i["rect"]["h"] * factorY).round();
        print(height);
       
       // File('thumbnail.png').writeAsBytesSync(encodePng(copyCrop(image,left, top,  width,  height)));
        
      
       
      var aux= copyCrop(image,left, top,  width,  height) ;
      print(aux);

      if(width>height){
          aux=copyResizeCropSquare(aux,height);
        }else{
          aux=copyResizeCropSquare(aux,width);
        }
       new File(appDocPath+"/image"+contador.toString()+".png").writeAsBytesSync(encodePng(aux));
       //File aux=new File(appDocPath+"image"+contador.toString()+".png");
print(appDocPath+"image"+contador.toString()+".png");
       
     contador+=1;
    }
      
  }
  