import 'package:flutter/material.dart';
import './views/book/full.dart';

class DetailScreen extends StatelessWidget {
  final book;

  DetailScreen({Key key, @required this.book}): super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Hardcover fiction"),
      ),
      body: new BookFull(book)
    );
  }
  
}