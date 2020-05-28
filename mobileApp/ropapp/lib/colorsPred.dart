
import 'package:image/image.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
  


  void colorPred(File img, List recognition, double _imageWidth , double _imageHeight)  async {
    print('IMHERE!!!!!!!!!!!!!!!!!!!!!!');
    print(recognition);
    Image image = decodeJpg(img.readAsBytesSync());
    
      double factorX = _imageWidth;
      double factorY = _imageHeight;
  
      int contador=0;
      
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
        
      
       Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      var aux= copyCrop(image,left, top,  width,  height) ;


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
  