import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:snack/snack.dart';

class CopyScreen  extends StatefulWidget {
  @override
  _CopyScreenState createState() => _CopyScreenState();
}

class _CopyScreenState extends State<CopyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class HomePage extends StatelessWidget {

  bool show = true;
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 
      title: 'something',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Column(
          children: <Widget>[
            InkWell(
              child: Text("Button1"),
              onTap: () {
                print("b");
                show = false;
                Flushbar(
                  title: 'Check',
                  message: 'Message',
                  duration: Duration(seconds: 2),
                ).show(context);
              },
            ),
            InkWell(
              child: Text("\nButton2"),
              onTap: () {
                print("b");
                show = false;
                final snackBar = SnackBar(content: Text('Profile saved'));
                globalKey.currentState.showSnackBar(snackBar); 
              },
            ),
            Builder(
              builder: (ctx) => RaisedButton(
              textColor: Colors.red,
              child: Text('Submit'),
              onPressed: () {
                Scaffold.of(ctx).showSnackBar(SnackBar(
                  content: Row(
                    children: <Widget>[
                      InkWell(
                        child: Text('data\t'),
                        onTap: () {
                          print('object');
                        },
                      ),
                      InkWell(
                        child: Text('data2\t'),
                        onTap: () {
                          print('object2');
                        },
                      ),
                      InkWell(
                        child: Text('data3\t'),
                        onTap: () {
                          print('object3');
                        },
                      ),
                    ],
                  ),//Text('Profile Save'),
                  duration: Duration(seconds: 20),
                ),);
              }               
              ),
            )
            //if (show%2==0) Text("data"),
            
          ],
        ),
      )
    );
  }
}


/*
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      home: Scaffold(
        body: Container(
        //Container(
          child: Center(
            child: MaterialButton(
              onPressed: (){
                print("you pressed it");
                Flushbar(
                  title:  "Hey Ninja",
                  message:  "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                  duration:  Duration(seconds: 3),              
                )..show(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
*/