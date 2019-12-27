import 'package:flutter/material.dart';

void main() => runApp(NYTBooksApp());

class NYTBooksApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NYTBooksState();
  }
}

class NYTBooksState extends State<NYTBooksApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
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