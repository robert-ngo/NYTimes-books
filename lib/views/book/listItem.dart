import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  final book;

  BookListItem(this.book);

  @override
  Widget build(BuildContext context) {
    final imageUrl = book["book_image"];
    final publisher = book["publisher"];
    final weeksOnList = book["weeks_on_list"];
    final author = book["author"];

    return new Container(
      padding: new EdgeInsets.all(16.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(imageUrl, width: 100.0,),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("$weeksOnList weeks on the list".toUpperCase(), style: TextStyle(fontSize: 12.0),),
                  Text(book["title"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),  
                  Text("by $author | $publisher",),
                  new Container(height: 8.0,),
                  Text(book["description"], style: TextStyle(fontFamily: 'georgia'),)
                ],
              ),
            ),
          ),
        ]
      )
    );
  }
  
}