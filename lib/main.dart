import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './views/book/listItem.dart';
import './detail.dart';

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
  var _isGridView = false;

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

  _renderListView() {
    return new ListView.builder(
              itemCount: this.books != null ? this.books.length : 0,
              itemBuilder: (context, i) {
                final book = this.books[i]; 

                return new FlatButton(
                  padding: EdgeInsets.all(0.0),
                  child: new BookListItem(book),
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new DetailScreen(book: book,)));
                  },
                );
              },
            );
  }

  _renderGridView() {
    return new GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              mainAxisSpacing: 16.0,
              padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 16.0),
              children: this.books.map<Widget>((book) {
                final title = book["title"];
                final imageUrl = book["book_image"];
                final author = book["author"];
                return new Container(
                  child: new Column(
                    children: <Widget>[
                      Image.network(imageUrl, height: 150.0,),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(height: 16.0,),
                            Text(title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(author),
                          ],
                        ),
                      ),
                    ],
                  )
                );
              }).toList()
            );
  }

  _render() {
    if (_isLoading) {
      return new CircularProgressIndicator();
    } else {
      if (_isGridView) {
        return _renderGridView();
      } else {
        return _renderListView();
      }
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
          title: new Text("NY Times - Hardcover fictions"),
          backgroundColor: Colors.white,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(_isGridView ? Icons.view_list : Icons.grid_on),
              onPressed: () {
                setState(() {
                  _isGridView = !_isGridView;
                });
              },
            ),
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
          child: _render()
            
        ),
      ),
    );
  }
} 