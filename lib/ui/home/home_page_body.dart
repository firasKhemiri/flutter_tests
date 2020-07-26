import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_experience/model/planets.dart';

import '../../utils.dart';
import 'planet_row.dart';


class HomePageBody extends StatefulWidget {
  @override
  _HomePageBody createState() => new _HomePageBody();
}

class _HomePageBody extends State<HomePageBody> {

  
  final controller = ScrollController();
  double appBarHeight = 200.0;

  SliverAppBar appBar(){
    return SliverAppBar(
      pinned: true,
      floating: false,
      
      expandedHeight: appBarHeight,
      backgroundColor: Colors.transparent,
      flexibleSpace: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      
        return FlexibleSpaceBar(
          
          centerTitle: true,
          title: Text("heeeeeeeeeeeeeeeey"),
          
          background:Center(
            
            child: Container(
              height: appBarHeight,

              child:Stack(
                children: <Widget>[


                  Transform.translate(
                    offset: Offset(0.0, -controller.offset),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(_calculateRadius(),),
                        ),
                      )
                    )
                  ),

                  
                  FadeOnScroll(
                    scrollController: controller,
                    fullOpacityOffset: 120,
                    
                    child: Stack(
                      children: <Widget> [
                        
                        // Image.asset(
                        //   "assets/img/vancouver.png",
                        //   fit: BoxFit.cover,
                        //   height: double.infinity,
                        //   width: double.infinity,
                        // ),

                        Transform.translate(
                          offset: Offset(0.0, -controller.offset),
                          child: Stack( 
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Details", style: TextStyle(color: Colors.black),)
                                      ),
                                      
                                      Spacer(),
                                              
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.menu, color: Colors.white),
                                      )
                                    ],
                                  ),
                                )
                                
                              ),

                            ],
                          )
                        )
                      ]
                    ),
                    
                  ),


                  FadeOnScroll(
                    scrollController: controller,
                    fullOpacityOffset: 120,
                    isFade: false,
                    
                    child: Transform.translate(
                      offset: Offset(0.0, 30),
                      child: Stack( 
                        children: <Widget>[

                          Text('wazzzzup', style: TextStyle(color: Colors.black),),
                        ]
                      )
                    )
                  ),

                ]
              ),

            )
          )
        );
      }
    ));
  }


  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: CustomScrollView(
        controller: controller,
          
          slivers: <Widget>[

            appBar(),

             SliverList(
                delegate: new SliverChildBuilderDelegate(
                  (context, index) => new PlanetRow(planets[index]),
                  childCount: planets.length,
                ),
              ),

          ],

        ),
    );
  }

double _calculateRadius() {
    var _offset = controller.offset;
    var fullOpacityOffset = 120;

    log('message:');
    if( _offset>= 0)
    {
      var dist = double.parse((_offset/fullOpacityOffset).toStringAsFixed(3));
      log('message:'+ dist.toString());
      
        return 40-(40*dist);
      
    }
    return 0;
  }
  
}
