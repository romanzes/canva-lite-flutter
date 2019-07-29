import 'dart:math';

import 'package:flutter/material.dart';

class CircumscribedInkResponse extends StatefulWidget {
  const CircumscribedInkResponse({
    Key key,
    this.child,
    this.onTap,
    this.onTapDown,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onHighlightChanged,
    this.borderRadius,
    this.customBorder,
    this.highlightColor,
    this.splashColor,
    this.splashFactory,
    this.enableFeedback = true,
    this.excludeFromSemantics = false,
  }) : super(key: key);

  final Widget child;
  final GestureTapCallback onTap;
  final GestureTapDownCallback onTapDown;
  final GestureTapCallback onTapCancel;
  final GestureTapCallback onDoubleTap;
  final GestureLongPressCallback onLongPress;
  final ValueChanged<bool> onHighlightChanged;
  final BorderRadius borderRadius;
  final ShapeBorder customBorder;
  final Color highlightColor;
  final Color splashColor;
  final InteractiveInkFeatureFactory splashFactory;
  final bool enableFeedback;
  final bool excludeFromSemantics;

  @override
  createState() => _CircumscribedInkResponse();
}

class _CircumscribedInkResponse extends State<CircumscribedInkResponse> {
  double _radius = 0;

  Widget build(BuildContext context) {
    return InkResponse(
      child: widget.child,
      onTap: widget.onTap,
      onTapDown: widget.onTapDown,
      onTapCancel: widget.onTapCancel,
      onDoubleTap: widget.onDoubleTap,
      onLongPress: widget.onLongPress,
      onHighlightChanged: widget.onHighlightChanged,
      containedInkWell: false,
      highlightShape: BoxShape.circle,
      radius: _radius,
      borderRadius: widget.borderRadius,
      customBorder: widget.customBorder,
      highlightColor: widget.highlightColor,
      splashColor: widget.splashColor,
      splashFactory: widget.splashFactory,
      enableFeedback: widget.enableFeedback,
      excludeFromSemantics: widget.excludeFromSemantics,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = (context.findRenderObject() as RenderBox).size;
      setState(() {
        _radius = sqrt(pow(size.width, 2) + pow(size.height, 2)) / 2;
      });
    });
    super.initState();
  }
}
