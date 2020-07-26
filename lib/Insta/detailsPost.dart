import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_experience/Insta/ui_utils.dart';

import 'heart_icon_animator.dart';

class DetailsPost extends StatefulWidget{
  final String url;
  final double height;
  final int distWidth;

  DetailsPost(this.url,this.height,this.distWidth);

  @override
  _DetailsPost createState() => new _DetailsPost();
}

class _DetailsPost extends State<DetailsPost> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MyDynamicHeader(url: this.widget.url, height: this.widget.height, minImgWidth: this.widget.distWidth),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                    return Container(

                      height: 200,
                      color: Color(Random().nextInt(0xffffffff)),
                      
                    );
                  },)
                )
              ],
            )
        )
    );
  }

}

class MyDynamicHeader extends SliverPersistentHeaderDelegate {
  int index = 0;
  double height;
  String url;
  int minImgWidth;


  MyDynamicHeader({
    @required this.height,
    @required this.url,
    @required this.minImgWidth
  }); 

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
        builder: (context, constraints) {
          
          final scWidth = MediaQuery.of(context).size.width;
          final Color color = Colors.primaries[index];
          final double percentage = (constraints.maxHeight - minExtent)/(maxExtent - minExtent);

          // Change this value to change when the image overlaps with header
          final limit = maxExtent - 155;
          final scrollDist = constraints.maxHeight - minExtent;


          if (++index > Colors.primaries.length-1)
            index = 0;

          return Container(

            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 4.0, color: Colors.black45)],
              gradient: LinearGradient(
                colors: [Colors.blue, color]
              ),
                
              borderRadius: lerp(BorderRadius.zero, 
                BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                ), 
                percentage
              ),
            ),
          
            child: SafeArea(

                child: Center(
                  
                  child: Stack(
                    children: <Widget>[
                  

                      Center(
                        child:Container(
                          margin: EdgeInsets.only(bottom: 0),
                          child:ClipRRect(
                            borderRadius: lerp(BorderRadius.zero, BorderRadius.circular(25), percentage, topOffset: 5),
                            child: Image.network(
                              url,
                              fit: BoxFit.fitWidth,

                              width: scrollDist <= limit 
                              ? scWidth 
                              : (((scrollDist-maxExtent)*(scWidth-(scWidth-minImgWidth)))/(limit-maxExtent))+(scWidth-minImgWidth)
                              
                            )
                          )
                        )
                      ),

                      CircularProgressIndicator(
                        value: percentage,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),


                      Positioned(
                        width: scWidth,
                        
                        // Change this value to change social bar postition
                        top: this.height-5 - ((maxExtent-constraints.maxHeight)/2.5),
                        
                        child:Center(
                          child: Opacity(

                            opacity: percentage,
                            child: ClipRect(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  
                              
                                  children: <Widget>[

                                    Container(
                                      width: 38,
                                      height: 150,
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: HeartIconAnimator(
                                        isLiked: true,
                                        size: 28.0,
                                        onTap: () {  },
                                      ),
                                    ),

                                    Container(
                                      width: 35,
                                      child: Text('24', style: bold),
                                    ),

                                    Container(
                                      width: 30,
                                      child: IconButton(
                                        padding: EdgeInsets.only(right: 10),
                                        iconSize: 28.0,
                                        icon: Icon(Icons.chat_bubble_outline),
                                        onPressed: () {  },
                                      ),
                                    ),

                                    Container(
                                      width: 20,
                                      child: Text("5", style: bold)
                                    ),
                                  
                                      
                                    Spacer(), 
                                    Spacer(),
                                    Spacer(),

                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      iconSize: 28.0,
                                      icon: Icon(Icons.bookmark), 
                                      onPressed: () {  },
                                    )


                                  ],
                                )
                              ),
                            )
                          ),
                          
                        )
                      )


                    ],
                  ),
                  
                
                )
            ),
            
          );
        }
    );
  }


  BorderRadius lerp(BorderRadius a, BorderRadius b, double t, {double botOffset = 1, double topOffset = 1}) {

    t = t<.5 ? 4*t*t*t : (t-1)*(2*t-2)*(2*t-2)+1;

    assert(t != null);
    if (a == null && b == null)
      return null;
    if (a == null)
      return b * t;
    if (b == null)
      return a * (1.0 - t);
    return BorderRadius.only(
      bottomLeft: Radius.lerp(a.bottomLeft, b.bottomLeft, pow(t, botOffset) ),
      bottomRight: Radius.lerp(a.bottomRight, b.bottomRight,  pow(t, botOffset)),
      topLeft: Radius.lerp(a.topLeft, b.topLeft,pow(t, topOffset)),
      topRight: Radius.lerp(a.topRight, b.topRight, pow(t, topOffset)),
    );
  }


  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  // Change this value ti change the height of the expanded header
  @override
  double get maxExtent => this.height+120;

  @override
  double get minExtent => 80.0;
}