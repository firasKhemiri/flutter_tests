import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  BorderRadiusTween borderRadius;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
  double _height, min = 0.1, initial = 0.3, max = 0.7;

  Animation<BorderRadius> _bordersAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
   
    _bordersAnimation = BorderRadiusTween(
  begin: BorderRadius.circular(4.0),
  end: BorderRadius.circular(75.0),
).animate(
  CurvedAnimation(
    parent: _controller,
    curve: Interval(
      0.375, 0.500,
      curve: Curves.bounceInOut,
    ),
  ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        child: FloatingActionButton(
          child: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _controller),
          elevation: 5,
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          onPressed: () async {
            if (_controller.isDismissed)
              _controller.forward();
            else if (_controller.isCompleted) _controller.reverse();
          },
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            FlutterLogo(size: 500),
            SizedBox.expand(
              child: SlideTransition(
                position: _tween.animate(_controller),
                
                child: DraggableScrollableSheet(
                  minChildSize: min, // 0.1 times of available height, sheet can't go below this on dragging
                  maxChildSize: max, // 0.7 times of available height, sheet can't go above this on dragging
                  initialChildSize: initial, // 0.1 times of available height, sheet start at this size when opened for first time
                  builder: (BuildContext context, ScrollController controller) {
                    return AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                      
                        return ClipRRect(
                         borderRadius: _bordersAnimation.value,
                          child: Container(
                            height: 500.0,
                            color: Colors.blue[800],
                            child: ListView.builder(
                              controller: controller,
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(title: Text('Item $index'));
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}