import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ropapp/home_widget.dart';
import 'package:ropapp/infoItem_Widget.dart';
import 'package:ropapp/values/values.dart';
import 'package:ropapp/item.dart';
import 'package:ropapp/infoItem_Widget.dart';
import 'package:http/http.dart' as http;

class resultWidget extends StatelessWidget {
  Future<Item> futureAlbum;

  @override
  final _info = const [
    {
      'tipo': 'Trousers',
      'res': [
        {
          'foto':
              r'https://images.asos-media.com/products/missguided-vice-high-waisted-super-stretch-skinny-jean-in-navy/6907157-1-indigo?$n_480w$&wid=476&fit=constrain',
          'precio': 27.99,
          'nombre':
              'Missguided vice high waisted super stretch skinny jean in navy',
          'link':
              'https://www.asos.com/missguided/missguided-vice-high-waisted-super-stretch-skinny-jean-in-navy/prd/6907157?clr=indigo&colourWayId=15468562&SearchQuery=jeans%20navy',
          "todas fotos": [
            r'https://images.asos-media.com/products/missguided-vice-high-waisted-super-stretch-skinny-jean-in-navy/6907157-1-indigo?$XXL$',
            r'https://images.asos-media.com/products/missguided-vice-high-waisted-super-stretch-skinny-jean-in-navy/6907157-2?$XXL$',
            r'https://images.asos-media.com/products/missguided-vice-high-waisted-super-stretch-skinny-jean-in-navy/6907157-3?$XXL$',
            r'https://images.asos-media.com/products/missguided-vice-high-waisted-super-stretch-skinny-jean-in-navy/6907157-4?$XXL$'
          ]
        },
        {
          'foto':
              r'https://images.asos-media.com/products/fila-baggy-utility-pants-with-embroidered-logo/13843268-1-navy?$n_480w$&wid=476&fit=constrain',
          'precio': 61.55,
          'nombre': 'Fila baggy utility pants with embroidered logo',
          'link':
              'https://www.asos.com/fila/fila-baggy-utility-pants-with-embroidered-logo/prd/13843268?clr=navy&colourWayId=16570650&SearchQuery=trousers',
          "todas fotos": [
            r'https://images.asos-media.com/products/fila-baggy-utility-pants-with-embroidered-logo/13843268-1-navy?$XXL$',
            r'https://images.asos-media.com/products/fila-baggy-utility-pants-with-embroidered-logo/13843268-2?$XXL$',
            r'https://images.asos-media.com/products/fila-baggy-utility-pants-with-embroidered-logo/13843268-3?$XXL$',
            r'https://images.asos-media.com/products/fila-baggy-utility-pants-with-embroidered-logo/13843268-4?$XXL$'
          ]
        },
        {
          'foto':
              r'https://images.asos-media.com/products/calvin-klein-full-length-performance-tights-in-night-sky/14947305-1-nightsky?$n_480w$&wid=476&fit=constrain',
          'precio': 66.99,
          'nombre': 'Calvin Klein full length performance tights in night sky',
          'link':
              'https://www.asos.com/calvin-klein/calvin-klein-full-length-performance-tights-in-night-sky/prd/14947305?clr=night-sky&colourWayId=16659329&SearchQuery=trousers',
          "todas fotos": [
            r'https://images.asos-media.com/products/calvin-klein-full-length-performance-tights-in-night-sky/14947305-1-nightsky?$XXL$',
            r'https://images.asos-media.com/products/calvin-klein-full-length-performance-tights-in-night-sky/14947305-2?$XXL$',
            r'https://images.asos-media.com/products/calvin-klein-full-length-performance-tights-in-night-sky/14947305-3?$XXL$',
            r'https://images.asos-media.com/products/calvin-klein-full-length-performance-tights-in-night-sky/14947305-4?$XXL$'
          ]
        },
        {
          'foto':
              r'https://images.asos-media.com/products/asos-design-petite-wide-leg-trousers-with-clean-high-waist/14375544-1-navy?$n_480w$&wid=476&fit=constrain',
          'precio': 34.99,
          'nombre':
              'ASOS DESIGN Petite wide leg trousers with clean high waist',
          'link':
              'https://www.asos.com/asos-petite/asos-design-petite-wide-leg-trousers-with-clean-high-waist/prd/14375544?clr=navy&colourWayId=16611671&SearchQuery=trousers',
          "todas fotos": [
            r'https://images.asos-media.com/products/asos-design-petite-wide-leg-trousers-with-clean-high-waist/14375544-1-navy?$XXL$',
            r'https://images.asos-media.com/products/asos-design-petite-wide-leg-trousers-with-clean-high-waist/14375544-2?$XXL$',
            r'https://images.asos-media.com/products/asos-design-petite-wide-leg-trousers-with-clean-high-waist/14375544-3?$XXL$',
            r'https://images.asos-media.com/products/asos-design-petite-wide-leg-trousers-with-clean-high-waist/14375544-4?$XXL$'
          ]
        },
      ],
    },
    {
      'tipo': 'Short Sleve Top',
      'res': [
        {
          'foto':
              r'https://images.asos-media.com/products/collusion-boxy-short-sleeve-t-shirt-in-pink/14100720-1-pink?$n_480w$&wid=476&fit=constrain',
          'precio': 8.49,
          'nombre': 'COLLUSION boxy short sleeve t shirt in pink',
          'link':
              'https://www.asos.com/collusion/collusion-boxy-short-sleeve-t-shirt-in-pink/prd/14100720?clr=pink&colourWayId=16591380&SearchQuery=tshirt',
          "todas fotos": [
            r'https://images.asos-media.com/products/collusion-boxy-short-sleeve-t-shirt-in-pink/14100720-1-pink?$XXL$',
            r'https://images.asos-media.com/products/collusion-boxy-short-sleeve-t-shirt-in-pink/14100720-2?$XXL$',
            r'https://images.asos-media.com/products/collusion-boxy-short-sleeve-t-shirt-in-pink/14100720-3?$XXL$',
            r'https://images.asos-media.com/products/collusion-boxy-short-sleeve-t-shirt-in-pink/14100720-4?$XXL$'
          ]
        },
        {
          'foto':
              r'https://images.asos-media.com/products/asos-design-curve-ultimate-organic-cotton-crew-neck-t-shirt-in-coral/14586204-1-coral?$n_480w$&wid=476&fit=constrain',
          'precio': 8.49,
          'nombre':
              'ASOS DESIGN Curve ultimate organic cotton crew neck t-shirt in coral',
          "todas fotos": [
            r'https://images.asos-media.com/products/asos-design-curve-ultimate-organic-cotton-crew-neck-t-shirt-in-coral/14586204-1-coral?$XXL$',
            r'https://images.asos-media.com/products/asos-design-curve-ultimate-organic-cotton-crew-neck-t-shirt-in-coral/14586204-2?$XXL$',
            r'https://images.asos-media.com/products/asos-design-curve-ultimate-organic-cotton-crew-neck-t-shirt-in-coral/14586204-3?$XXL$',
            r'https://images.asos-media.com/products/asos-design-curve-ultimate-organic-cotton-crew-neck-t-shirt-in-coral/14586204-4?$XXL$'
          ]
        },
        {
          'foto':
              r'https://images.asos-media.com/products/asos-design-tall-ultimate-organic-cotton-crew-neck-t-shirt-in-coral/14586182-1-coral?$n_480w$&wid=476&fit=constrain',
          'precio': 8.49,
          'nombre':
              'ASOS DESIGN Tall ultimate organic cotton crew neck t-shirt in coral',
          'link':
              'https://www.asos.com/asos-tall/asos-design-tall-ultimate-organic-cotton-crew-neck-t-shirt-in-coral/prd/14586182?clr=coral&colourWayId=16628039&SearchQuery=tshirt',
          "todas fotos": [
            r'https://images.asos-media.com/products/asos-design-tall-ultimate-organic-cotton-crew-neck-t-shirt-in-coral/14586182-1-coral?$XXL$',
            r'https://images.asos-media.com/products/asos-design-tall-ultimate-organic-cotton-crew-neck-t-shirt-in-coral/14586182-2?$XXL$',
            r'https://images.asos-media.com/products/asos-design-tall-ultimate-organic-cotton-crew-neck-t-shirt-in-coral/14586182-3?$XXL$',
            r'https://images.asos-media.com/products/asos-design-tall-ultimate-organic-cotton-crew-neck-t-shirt-in-coral/14586182-4?$XXL$'
          ]
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                itemCount: _info.length,
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
                                    _info[index]['tipo'],
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
                                      ...(_info[index]['res']
                                              as List<Map<String, Object>>)
                                          .map((item) {
                                        return Item(
                                            item['foto'],
                                            item['precio'],
                                            () => lookItem(context, item));
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
              images: item["todas fotos"],
              link: item["link"]),
        ));
  }
}
