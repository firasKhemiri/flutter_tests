import 'package:flutter/material.dart';

class Positio extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    
    return Container(
      constraints: BoxConstraints.loose(Size.fromHeight(60.0)),
      decoration: BoxDecoration(color: Colors.black), 
      child: 
        Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: [
            Positioned(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              left: -5.0,
              child: Container(
                color: Colors.grey,
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Center(
                          child: Text("Green")
                      ),
                    ),
                    Container(
                      color: Colors.pink,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Center(child: Text("Pink"))
                    ),
                    Container(
                      color: Colors.blue,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Center(child: Text("Blue")),
                    )
                  ],
                ),
              ),
            ),
          ]
        )
    );
    
  }

}