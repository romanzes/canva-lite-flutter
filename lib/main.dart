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
                      FancyButton(
                        text: 'Add',
                        onTap: () {
                          final RenderBox box =
                              _canvasKey.currentContext.findRenderObject();
                          _elementsBloc.addElement(box.size);
                        },
                      ),
                      FancyButton(
                        text: 'Remove',
                        onTap: () {
                          /* ... */
                        },
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
  }) : super(key: key);

  final String text;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CircumscribedInkResponse(
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        highlightColor: Colors.transparent,
        splashColor: Color(0x1f000000),
        splashFactory: InkRipple.splashFactory,
        onTap: onTap,
      ),
    );
  }
}
