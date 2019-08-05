import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'canvas.dart';
import 'circumscribed_ink_response.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canva Lite Flutter',
      theme: ThemeData(
        canvasColor: Color(0xff3F51B5),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _canvasKey = GlobalKey();
  ElementsBloc _elementsBloc;

  @override
  void initState() {
    super.initState();
    _elementsBloc = ElementsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Material(
          child: Padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Canva Lite',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                      ),
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1.0,
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Canvas(
                      elementsBloc: _elementsBloc,
                      key: _canvasKey,
                    ),
                    color: Colors.white,
                    elevation: 4,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FancyButton(
                          text: 'Add',
                          onTap: () {
                            final RenderBox box =
                                _canvasKey.currentContext.findRenderObject();
                            _elementsBloc.addElement(box.size);
                          },
                        ),
                      ),
                      Expanded(
                        child: RemoveButton(elementsBloc: _elementsBloc),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _elementsBloc.dispose();
    super.dispose();
  }
}

class FancyButton extends StatelessWidget {
  const FancyButton({
    Key key,
    this.text,
    this.onTap,
    this.enable = true,
  }) : super(key: key);

  final String text;
  final GestureTapCallback onTap;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return CircumscribedInkResponse(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: enable ? Colors.white : Colors.grey,
            fontSize: 18,
          ),
        ),
      ),
      highlightColor: Colors.transparent,
      splashColor: Color(0x1f000000),
      splashFactory: InkRipple.splashFactory,
      onTap: enable ? onTap : null,
    );
  }
}

class RemoveButton extends StatefulWidget {
  const RemoveButton({
    Key key,
    @required this.elementsBloc,
  }) : super(key: key);

  final ElementsBloc elementsBloc;

  @override
  _RemoveButton createState() => _RemoveButton();
}

class _RemoveButton extends State<RemoveButton> {
  String _animation;

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      builder: (context, data, rejectedData) {
        return CircumscribedInkResponse(
          child: Center(
            child: FlareActor(
              "assets/bin.flr",
              color: Colors.white,
              animation: _animation,
            ),
          ),
          highlightColor: Colors.transparent,
          splashColor: Color(0x1f000000),
          splashFactory: InkRipple.splashFactory,
          onTap: () {
            widget.elementsBloc.removeLastElement();
          },
        );
      },
      onWillAccept: (data) {
        debugPrint('draggable is on the target');
        setState(() {
          _animation = "Open";
        });
        return true;
      },
      onAccept: (data) {
        widget.elementsBloc.removeElement(data);
        setState(() {
          _animation = "Close";
        });
      },
      onLeave: (data) {
        debugPrint('draggable has left the target');
        setState(() {
          _animation = "Close";
        });
      },
    );
  }
}
