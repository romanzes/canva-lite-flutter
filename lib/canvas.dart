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
              .map((element) => Positioned(
                    child: Container(color: element.color),
                    left: element.x,
                    top: element.x,
                    width: element.width,
                    height: element.height,
                  ))
              .toList(),
        );
      },
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
        Element(x: 0, y: 0, width: 100, height: 100, color: color);
    _elements.add(newElement);
    _elementsStreamController.add(_elements);
  }

  void dispose() {
    _elementsStreamController.close();
  }
}

class Element {
  const Element({
    @required this.x,
    @required this.y,
    @required this.width,
    @required this.height,
    @required this.color,
  });

  final double x;
  final double y;
  final double width;
  final double height;
  final Color color;
}
