
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';

class Shaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          shape: CustomShapeBorder(),
          leading: Icon(Icons.menu),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.notifications),onPressed: (){},)
          ],
        ),
        body: Container(),
      ),
    );
  }
}

class CustomShapeBorder extends ContinuousRectangleBorder {

CustomShapeBorder({
  Key key, 
  this.val = 150,
});
  double val;


  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {

    double innerCircleRadius = val;

    Path path = Path();
    path.lineTo(0, rect.height);
    path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 30, rect.height + 15, rect.width / 2 - 75, rect.height + 50);
    path.cubicTo(
        rect.width / 2 - 40, rect.height + innerCircleRadius - 40,
        rect.width / 2 + 40, rect.height + innerCircleRadius - 40,
        rect.width / 2 + 75, rect.height + 50
    );
    path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30, rect.height + 15, rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    log("val off: "+innerCircleRadius.toString());

    return path;
  }
}