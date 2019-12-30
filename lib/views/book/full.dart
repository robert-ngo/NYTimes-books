import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookFull extends StatelessWidget {
  final book;

  BookFull(this.book);

  @override
  Widget build(BuildContext context) {
    
    final imageUrl = book["book_image"];
    final publisher = book["publisher"];
    final weeksOnList = book["weeks_on_list"];
    final author = book["author"];

    _launchUrl() async {
      final amazonProductURL = book["amazon_product_url"];
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
                    Text(book["title"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),  
                    Text("by $author | $publisher",),
                  ],
                ),
              ),
              
              Text(book["description"], style: TextStyle(fontFamily: 'georgia', fontSize: 16.0),),  

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