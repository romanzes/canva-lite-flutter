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
    return StreamBuilder<List<CanvasElement>>(
      stream: widget.elementsBloc.elements,
      initialData: List<CanvasElement>(),
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

  final CanvasElement element;

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
  final _elementsStreamController =
      StreamController<List<CanvasElement>>.broadcast();

  Random _random = Random();
  List<CanvasElement> _elements = List<CanvasElement>();

  Stream<List<CanvasElement>> get elements => _elementsStreamController.stream;

  void addElement(Size canvasSize) {
    double elementSize = 100;
    double left = _random.nextDouble() * (canvasSize.width - elementSize);
    double top = _random.nextDouble() * (canvasSize.height - elementSize);
    double hue = _random.nextDouble() * 360;
    Color color = HSLColor.fromAHSL(1.0, hue, 1.0, 0.5).toColor();
    CanvasElement newElement = CanvasElement(
        position: Offset(left, top),
        size: Size(elementSize, elementSize),
        color: color);
    _elements.add(newElement);
    _elementsStreamController.add(_elements);
  }

  bool hasElements() {
    return _elements.length > 0;
  }

  void removeElement(int index) {
    _elements.removeAt(index);
    _elementsStreamController.add(_elements);
  }

  void removeLastElement() {
    if (hasElements()) {
      _elements.removeLast();
    }
    _elementsStreamController.add(_elements);
  }

  void dispose() {
    _elementsStreamController.close();
  }
}

class CanvasElement {
  CanvasElement({
    @required this.position,
    @required this.size,
    @required this.color,
  });

  Offset position;
  Size size;
  Color color;
}
