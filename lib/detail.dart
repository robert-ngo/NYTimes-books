import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Detail page"),
      ),
      body: new Center(
        child: new Text("Detail content"),
      ),
    );
  }
  
}