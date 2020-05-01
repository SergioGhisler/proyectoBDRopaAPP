/*
*  transition1_widget_animation1_element2.dart
*  DISEÑO APP
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'dart:math';
import 'package:ropapp/values/values.dart';
import 'package:flutter/widgets.dart';
import 'package:supernova_flutter_ui_toolkit/keyframes.dart';

Animation<double> _createRotationZProperty(AnimationController animationController) => Interpolation<double>(keyframes: [
  
  Keyframe<double>(fraction: 0, value: 0),
  Keyframe<double>(fraction: 0.32203, value: -360),
  Keyframe<double>(fraction: 0.40678, value: -400),
  Keyframe<double>(fraction: 0.49153, value: -360),
  Keyframe<double>(fraction: 0.83051, value: 0),
  Keyframe<double>(fraction: 0.91525, value: 40),
  Keyframe<double>(fraction: 1, value: 0),
]).animate(CurvedAnimation(
  curve: Interval(0, 1, curve: Cubic(0.42, 0, 0.58, 1)),
  parent: animationController,
));


class TransitionWidgetElement2 extends StatelessWidget {
  
  TransitionWidgetElement2({
    Key key,
    this.child,
    @required AnimationController animationController
  }) : assert(animationController != null),
       this.rotationZ = _createRotationZProperty(animationController),
       super(key: key);
  
  final Animation<double> rotationZ;
  final Widget child;
  
  
  @override
  Widget build(BuildContext context) {
  
    return AnimatedBuilder(
      
      
      animation: Listenable.merge([
        this.rotationZ,
      ]),
      
      child: this.child,
      builder: (context, widget) {
      
        return Transform.rotate(
        
          angle: this.rotationZ.value / 180 * pi,
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}