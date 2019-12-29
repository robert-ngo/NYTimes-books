import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  var _isLoading = true;

  var books;

  _fetchData() async {
    print("Fetching data from server.");

    final apiKey = "uZNGAfYfD79HcCYFwe2UwUv6ADvq0G5U";
    final nytEndpoint = "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=$apiKey";

    final response = await http.get(nytEndpoint);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _isLoading = false;
        this.books = data["results"]["books"];
      });
    }
    
  }

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
                setState(() {
                  _isLoading = true;
                });
                _fetchData();
              },
            )
          ],
        ),
        body: new Center(
          child: _isLoading ? new CircularProgressIndicator() : 
            new ListView.builder(
              itemCount: this.books != null ? this.books.length : 0,
              itemBuilder: (context, i) {
                final book = this.books[i];

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
              },
            )
        ),
      ),
    );
  }
} 