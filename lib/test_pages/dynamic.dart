import 'dart:math';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget{

  @override
  _MyWidget createState() => new _MyWidget();
}

class _MyWidget extends State<MyWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MyDynamicHeader(),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                      return Container(
                        height: 200,
                        color: Color(Random().nextInt(0xffffffff)),
                      );
                    },
                    )
                )
              ],
            )
        )
    );
  }

}

class MyDynamicHeader extends SliverPersistentHeaderDelegate {
  int index = 0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final Color color = Colors.primaries[index];
          final double percentage = (constraints.maxHeight - minExtent)/(maxExtent - minExtent);

          if (++index > Colors.primaries.length-1)
            index = 0;

          return Container(

            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 4.0, color: Colors.black45)],
              gradient: LinearGradient(
                colors: [Colors.blue, color]
              ),
                
              borderRadius: lerp(BorderRadius.zero, BorderRadius.circular(30), percentage),
              ),
          
            height: constraints.maxHeight,
            child: SafeArea(
                child: Center(
                  child: CircularProgressIndicator(
                    value: percentage,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
            ),
            
          );
        }
    );
  }


BorderRadius lerp(BorderRadius a, BorderRadius b, double t) {

  assert(t != null);
  if (a == null && b == null)
    return null;
  if (a == null)
    return b * t;
  if (b == null)
    return a * (1.0 - t);
  return BorderRadius.only(
    bottomLeft: Radius.lerp(a.bottomLeft, b.bottomLeft, t),
    bottomRight: Radius.lerp(a.bottomRight, b.bottomRight, t),
  );
}


  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 250.0;

  @override
  double get minExtent => 80.0;
}