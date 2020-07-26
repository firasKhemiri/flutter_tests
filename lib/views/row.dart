

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_experience/model/post.dart';

class PostItemRow extends StatelessWidget {

  final Post post;

  const PostItemRow({Key key, this.post}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {

    final userThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
        vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage('https://via.placeholder.com/140x100')
      )
    );

    final baseTextStyle = const TextStyle(
        fontFamily: 'Poppins'
      );
      
    final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 9.0,
      fontWeight: FontWeight.w400
    );


    final subHeaderTextStyle = regularTextStyle.copyWith(
      fontSize: 12.0
    );

    final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600
    );

    final headerRow = Row(
      children: <Widget>[
          userThumbnail,

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('John doe',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
              Text('John doe',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)
            ],
          ),

          Spacer(),

          IconButton(icon: Icon(Icons.more_vert), onPressed: null)



      ],
    );

    final cardContent= Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      constraints: BoxConstraints.expand(),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          headerRow,

          Container(
            child:  ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/img/vancouver.png',
                width: 300,
                height: 210.0,
                fit: BoxFit.fill,
              ),
            ),
          ),

          headerRow

        ],
      ),

    );


    final card = Container(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10 ),
      
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            ),
          ]
        ),

      child: cardContent,
    );


    return new Container(
    
      height: 320.0,
      child: card,
    );

  }

}