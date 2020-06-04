/*
Clase que nos permite tener la vista de la página web.
*/


import 'dart:async';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebWidget extends StatefulWidget {
  final String link;

  WebWidget({Key key, @required this.link}) : super(key: key);
  @override
  _WebWidgetState createState() => _WebWidgetState();
}

class _WebWidgetState extends State<WebWidget> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    print(widget.link);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tienda"),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.link,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        );
      }),
    );
  }
}
