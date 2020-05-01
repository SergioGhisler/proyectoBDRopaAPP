/*
*  transition1_widget.dart
*  DISEÑO APP
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:ropapp/result_widget.dart';
import 'package:ropapp/transicion/transition_widget_element1.dart';
import 'transition_widget_element2.dart';
import 'package:ropapp/values/values.dart';
import 'package:ropapp/home_widget.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:ropapp/prueba.dart';
class TransitionWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransitionWidgetState();
}

class _TransitionWidgetState extends State<TransitionWidget>
    with TickerProviderStateMixin {
  AnimationController group3ImageAnimationController;
  AnimationController group4ImageAnimationController;

  @override
  void initState() {
    super.initState();

    this.group3ImageAnimationController = AnimationController(
        duration: Duration(milliseconds: 6000), vsync: this);
    this.group4ImageAnimationController = AnimationController(
        duration: Duration(milliseconds: 6000), vsync: this);
    for (int i = 0; i < 3; i++) {
      this.startAnimationOne();
      this._startPaperAnimation();
    }
  }

  @override
  void dispose() {
    super.dispose();

    this.group3ImageAnimationController.dispose();
    this.group4ImageAnimationController.dispose();
  }

  void startAnimationOne() {
    this.group3ImageAnimationController.forward();
    this.group4ImageAnimationController.forward();
  }

  Future _startPaperAnimation() async {
    this.group3ImageAnimationController.repeat();
    this.group4ImageAnimationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Color.fromARGB(255, 0, 2, 49),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 2, 49),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned(
              top: HomeWidget.phoneBlockHeight * 25,
              child: TransitionWidgetElement1(
                animationController: this.group3ImageAnimationController,
                child: Image.asset(
                  "assets/images/group-3-2.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: HomeWidget.phoneBlockHeight * 25,
              child: TransitionWidgetElement2(
                animationController: this.group4ImageAnimationController,
                child: Image.asset(
                  "assets/images/group-4-2.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => resultWidget()),
          );
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
