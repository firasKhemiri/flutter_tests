import 'package:flutter/material.dart';
import 'package:flutter_experience/test_pages/shapePage.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double targetElevation = 3;
  double _elevation = 0;
  ScrollController _controller;
  double rad = 0;

  void _scrollListener() {
    double newElevation = targetElevation;
    double newRad = _controller.offset > 1 ? 40 : 0;
    if (_elevation != newElevation) {
      setState(() {
        _elevation = newElevation;
        rad = newRad;
      });
    }
  }


  

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.removeListener(_scrollListener);
    _controller?.dispose();
  }


  SliverAppBar appbar()
  {
    return SliverAppBar(
      title: Text(
                'ElevationAppBar',
                style: TextStyle(color: Colors.black54),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              elevation: _elevation,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ElevationAppBar',
          style: TextStyle(color: Colors.black54),  
        ),
        backgroundColor: Colors.blue,
        shape: CustomShapeBorder(val: 50),
        leading: Icon(Icons.menu),
        actions: <Widget>[
            IconButton(icon: Icon(Icons.notifications),onPressed: (){},)
          ],
        centerTitle: true,
        elevation: _elevation,
      ),
      
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: <Widget>[
            Center(
              child: Text('Hello world!'),
            ),
            Center(
              child: Text('Hello world!'),
            ),
            Center(
              child: Text('Hello world!'),
            ),
            Center(
              child: Text('Hello world!'),
            ),
            Center(
              child: Text('Hello world!'),
            ),
            Center(
              child: Text('Hello world!'),
            ),
            Center(
              child: Text('Hello world!'),
            ),
            SizedBox(
              height: 1000,
            )
          ],
        ),
      ),
    );
  }
}