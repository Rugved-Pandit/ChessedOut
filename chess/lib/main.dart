import 'package:flutter/material.dart';
import './Screen1.dart';
import './CopyScreen.dart';
import 'package:flutter/services.dart';

void main() => runApp(chess());

class chess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chess',
      home: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/chessimg6.jfif'),
              fit: BoxFit.fill,
            )
          ),
          child: Screen1(),
        )
      // home: HomePage(),
    );
  }
}