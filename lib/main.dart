import 'package:flutter/material.dart';

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
                    color: Colors.white,
                    elevation: 4,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: CircumscribedInkResponse(
                          child: Center(
                            child: Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          highlightColor: Colors.transparent,
                          splashColor: Color(0x1f000000),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () {
                            /* ... */
                          },
                        ),
                      ),
                      Expanded(
                        child: CircumscribedInkResponse(
                          child: Center(
                            child: Text(
                              'Remove',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          highlightColor: Colors.transparent,
                          splashColor: Color(0x1f000000),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () {
                            /* ... */
                          },
                        ),
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
}
