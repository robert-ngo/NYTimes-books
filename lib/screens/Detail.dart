import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/Book.dart';

class DetailScreen extends StatelessWidget {
  final Book book;

  DetailScreen({Key key, @required this.book}): super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Hardcover fiction"),
      ),
      body: new BookDetail(book: book)
    );
  }
  
}

class BookDetail extends StatelessWidget {
  final Book book;

  BookDetail({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = book.title;
    final String imageUrl = book.imageUrl;
    final String description = book.description;
    final String publisher = book.publisher;
    final String weeksOnList = book.weeksOnList.toString();
    final String author = book.author;

    _launchUrl() async {
      final amazonProductURL = book.amazonUrl;
      print(amazonProductURL);

      if (await canLaunch(amazonProductURL)) {
        await launch(amazonProductURL);
      } else {
        throw 'Could not launch $amazonProductURL';
      }
    }


    return Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.network(imageUrl, width: 180.0,),
              new Container(height: 16.0,),
              Text("$weeksOnList weeks on the list".toUpperCase(), style: TextStyle(fontSize: 12.0),),
              Padding( 
                padding: EdgeInsets.symmetric(
                  vertical: 16.0
                ),
                child: Column(
                  children: <Widget>[
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),  
                    Text("by $author | $publisher",),
                  ],
                ),
              ),
              
              Text(description, style: TextStyle(fontFamily: 'georgia', fontSize: 16.0),),  

              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.0
                ),
                child: RaisedButton.icon(
                  icon: Icon(Icons.shopping_cart, color: Colors.white,),
                  label: Text('Amazon', style: TextStyle(color: Colors.white),),
                  color: Colors.black,
                  onPressed: _launchUrl
                ),
              ),
            ],
          ),
        ),
      );
  }

}