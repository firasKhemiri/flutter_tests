import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_experience/Insta/detailsPost.dart';

class ImageHeight extends StatefulWidget{
  @override
  _ImageHeight createState() {
    return new _ImageHeight();
  }

}


class _ImageHeight extends State<ImageHeight> {

  Size size;

  final String url = 
  // "https://i.stack.imgur.com/lkd0a.png";
  // 'http://images-jp.amazon.com/images/P/4101098018.09.MZZZZZZZ';
  //  'https://www.abc.net.au/cm/rimage/10915846-16x9-xlarge.jpg?v=3';
   'https://www.liquor.com/thmb/aWhN261DvzVivRjZj-VX6Xt3hAA=/735x0/__opt__aboutcom__coeus__resources__content_migration__liquor__2009__11__05151251__flaming-dr-pepper-shot-8170731e3a1b411889fb524fdbbd2205.jpg';
  //  'https://tutorialscapital.com/wp-content/uploads/2017/09/background.jpg';

  _ImageHeight(){
    // getTextFromFile().then((value) => setState(() {
    //       size = value;
    //       print("width ${size.width}");
    //     }));
  }
  
  Widget build(BuildContext context) {
    var scWidth = MediaQuery.of(context).size.width;
    return new FutureBuilder<ui.Image>(
      future: _getImage(),
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {

        if (snapshot.hasData) {
          print('${snapshot.data.width} X ${snapshot.data.height}');

          final distWidth = 40;
          
          var aspect = snapshot.data.height/snapshot.data.width;
                        
          var height = (snapshot.data.height-distWidth*aspect)* ((scWidth)/snapshot.data.width);

          return DetailsPost(url, height, distWidth);
        } 
        else {
          return Text('Loading...');
        }
      }
    );
  }



  Future<ui.Image> _getImage() async {
    final Completer<ui.Image> completer = Completer<ui.Image>();
    Image image = Image.network(url);

    image.image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool isSync) {
          print(info.image.width);
          completer.complete(info.image);
        }));


    return completer.future;
  }

}