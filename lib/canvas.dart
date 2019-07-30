import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Canvas extends StatefulWidget {
  const Canvas({
    Key key,
    @required this.elementsBloc,
  }) : super(key: key);

  final ElementsBloc elementsBloc;

  @override
  _Canvas createState() => _Canvas();
}

class _Canvas extends State<Canvas> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Element>>(
      stream: widget.elementsBloc.elements,
      initialData: List<Element>(),
      builder: (context, snapshot) {
        return Stack(
          children: snapshot.data
              .map((element) => ElementView(element: element))
              .toList(),
        );
      },
    );
  }
}

class ElementView extends StatefulWidget {
  ElementView({
    @required this.element,
  });

  final Element element;

  @override
  State<StatefulWidget> createState() {
    return _ElementView();
  }
}

class _ElementView extends State<ElementView> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Draggable(
        child: Container(
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: widget.element.color,
          ),
          width: widget.element.size.width,
          height: widget.element.size.height,
        ),
        childWhenDragging: Container(
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: widget.element.color.withOpacity(0.5),
          ),
          width: widget.element.size.width,
          height: widget.element.size.height,
        ),
        feedback: Container(
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: widget.element.color,
            elevation: 8,
          ),
          width: widget.element.size.width,
          height: widget.element.size.height,
        ),
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            RenderBox getBox = context.findRenderObject().parent;
            widget.element.position = getBox.globalToLocal(offset);
          });
        },
      ),
      left: widget.element.position.dx,
      top: widget.element.position.dy,
    );
  }
}

class ElementsBloc {
  final _elementsStreamController = StreamController<List<Element>>();

  Random _random = Random();
  List<Element> _elements = List<Element>();

  Stream<List<Element>> get elements => _elementsStreamController.stream;

  void addElement() {
    double hue = _random.nextDouble() * 360;
    Color color = HSLColor.fromAHSL(1.0, hue, 1.0, 0.5).toColor();
    Element newElement =
        Element(position: Offset(0, 0), size: Size(100, 100), color: color);
    _elements.add(newElement);
    _elementsStreamController.add(_elements);
  }

  void dispose() {
    _elementsStreamController.close();
  }
}

class Element {
  Element({
    @required this.position,
    @required this.size,
    @required this.color,
  });

  Offset position;
  Size size;
  Color color;
}
