import 'package:flutter/material.dart';
import 'package:ropapp/values/values.dart';
import 'package:ropapp/home_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nice_button/nice_button.dart';
import 'package:ropapp/web_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InfoWidget extends StatelessWidget {
  @override
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  final String text;
  final List images;
  final String link;

  InfoWidget(
      {Key key,
      @required this.text,
      @required this.images,
      @required this.link})
      : super(key: key);
      
  Widget build(BuildContext context) {
    print(images);
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
        child: new Column(
          children: <Widget>[
            Container(
              width: HomeWidget.phoneWidth,
              height: HomeWidget.phoneBlockHeight * 15,
              child: Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/logoRopapp.png",
                  width: HomeWidget.phoneBlockWidth * 50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Montserrat",
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              
              height: HomeWidget.phoneBlockHeight * 60,
              child: Swiper(

                itemBuilder: (BuildContext context, int index) {
                  return Image.network(images[index], fit: BoxFit.cover);
                },
                itemCount: images.length,
                layout: SwiperLayout.STACK,
                pagination: SwiperPagination(alignment: Alignment.bottomCenter),
                itemHeight: HomeWidget.phoneBlockHeight * 50,
                itemWidth: 300.0,

              ),
            ),
            NiceButton(
              radius: 40,
              padding: const EdgeInsets.all(15),
              text: "Ver en tienda",
              icon: Icons.shopping_basket,
              gradientColors: [secondColor, firstColor],
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebWidget(
                            link: link,
                          )),
                );
              },
              background: null,
            )
          ],
        ),
      ),
    );
  }
}
