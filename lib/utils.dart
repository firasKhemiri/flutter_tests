import 'package:flutter/material.dart';

class FadeOnScroll extends StatefulWidget {
  final ScrollController scrollController;
  final double zeroOpacityOffset;
  final double fullOpacityOffset;
  final Widget child;
  final bool isFade;

  FadeOnScroll(
    {
      Key key,
      @required this.scrollController,
      @required this.child,
      this.zeroOpacityOffset = 0,
      this.fullOpacityOffset = 0,
      this.isFade = true
    }
  );

  @override
  _FadeOnScrollState createState() => _FadeOnScrollState();
}

class _FadeOnScrollState extends State<FadeOnScroll> {
  double _offset;

  @override
  initState() {
    super.initState();
    _offset = widget.scrollController.offset;
    widget.scrollController.addListener(_setOffset);
  }

  @override
  dispose() {
    widget.scrollController.removeListener(_setOffset);
    super.dispose();
  }

  void _setOffset() {
    setState(() {
      _offset = widget.scrollController.offset;
    });
  }

  double _calculateOpacity() {

    if(_offset < widget.fullOpacityOffset && _offset> widget.zeroOpacityOffset)
    {
      var dist = double.parse((_offset/widget.fullOpacityOffset).toStringAsFixed(3));
      
      if (widget.isFade)
        return 1-dist;
      else return dist;
    }

    if (_offset >= widget.fullOpacityOffset)
      if (widget.isFade)
        return 0;
      else return 1;

    else if (_offset <= widget.zeroOpacityOffset)
      if (widget.isFade)
        return 1;
      else return 0;
  
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _calculateOpacity(),
      child: widget.child,
      
    );
  }
}