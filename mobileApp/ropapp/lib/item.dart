import 'package:flutter/material.dart';
import 'package:ropapp/values/values.dart';
import 'package:ropapp/home_widget.dart';

class Item extends StatelessWidget {
  final String photo;
  final double precio;
  final Function action;
  const Item(this.photo, this.precio,this.action);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(HomeWidget.phoneBlockHeight*1, HomeWidget.phoneBlockHeight*1, HomeWidget.phoneBlockHeight*1, 0),
      child: FlatButton(

        padding: EdgeInsets.all(0),
        onPressed: action,
              child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
                child: Image.network(
                photo,
                height: HomeWidget.phoneBlockHeight*20,
               
              ),
            ),
            Container(margin: EdgeInsets.only(top:HomeWidget.phoneBlockHeight*1),),
            Text(
              precio.toString() + " EUR",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Montserrat",
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
