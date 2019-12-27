import 'package:flutter/material.dart';

void main() => runApp(NYTBooksApp());

// 1. Create the NYTBooksApp class by extending StatefulWidget, 
// we then have to override method createState() by returning 
// an instance of class NYTBooksState()
class NYTBooksApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NYTBooksState();
  }
}

// 2. Class NYTBooksState()
class NYTBooksState extends State<NYTBooksApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // 2.1 Customize app theme by changing primaryColor
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),

      // 2.2 Build the home screen, with:
      // - appBar on top showing the app name, and a refresh button
      // - body with a CircularProcessIndicator() in the center
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("NY Times books"),
          backgroundColor: Colors.white,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                print("Reloading ...");
              },
            )
          ],
        ),
        body: new Center(
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
} 