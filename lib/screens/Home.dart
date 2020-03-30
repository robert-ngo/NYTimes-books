import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

// 1. add Book data model 
class Book {
  final String title;
  final String imageUrl;
  final String description;
  final String publisher;
  final int weeksOnList;
  final String author;

  Book({this.title, this.imageUrl, this.description, this.publisher, this.weeksOnList, this.author});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      imageUrl: json['book_image'],
      description: json['description'],
      publisher: json['publisher'], 
      weeksOnList: json['weeks_on_list'], 
      author: json['author']
    );
  }
}

// 2. API call request
Future<List<Book>> fetchBooks(http.Client client) async {
  print("Fetching data from server.");
  final apiKey = "uZNGAfYfD79HcCYFwe2UwUv6ADvq0G5U";
  final nytEndpoint = "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=$apiKey";
  final response = await client.get(nytEndpoint);
  return compute(parseBooks, response.body);
}

// 3.  Function to convert a response body into List<Book>
List<Book> parseBooks(String responseBody) {
  final data = json.decode(responseBody);
  final parsed = data["results"]["books"].cast<Map<String, dynamic>>();
  return parsed.map<Book>((json) => Book.fromJson(json)).toList();
}

/*
 * The HomeScreen component.
 */
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}
class HomeScreenState extends State<HomeScreen> {
  var _isGridView = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        ],
      ),
      body: FutureBuilder<List<Book>>(
        future: fetchBooks(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print (snapshot.error);
          return snapshot.hasError 
            ? Center(child: CircularProgressIndicator())
            : _isGridView 
              ? BookGrid(books: snapshot.data) 
              : BookList(books: snapshot.data);
        },
      )
    );
  }
}

/*
 * BookGrid componenent. 
 * Render List<Book> as a grid of 2 columns.
 */
class BookGrid extends StatelessWidget {
  final List<Book> books;

  BookGrid({Key key, this.books}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 2.0, 
        childAspectRatio: 1/1.3 // @TODO: calculate ratio base on screensize 
      ), 
      itemCount: books.length,
      itemBuilder: (context, index) {
        final Book book = books[index];
        return new BookGridItem(book);
      }
    );
  }
}

/*
 * BookGridItem component. 
 */
class BookGridItem extends StatelessWidget {
  final Book book;

  BookGridItem(this.book);

  @override
  Widget build(BuildContext context) {
    final String title = book.title;
    final imageUrl = book.imageUrl;
    final author = book.author;

    return new Container(
      padding: const EdgeInsets.all(16.0),
      margin: new EdgeInsets.all(1.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.network(imageUrl, height: 150.0,),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: <Widget>[
                Text(title, 
                  textAlign: TextAlign.center, 
                  style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                Text(author)
              ]
            )
          )
        ]
      )
    );
  }
  
}

/*
 * BookList componenent. 
 * Render List<Book> as a single column list.
 */
class BookList extends StatelessWidget {
  final List<Book> books;

  BookList({Key key, this.books}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return new ListView.builder(
          itemCount: this.books != null ? this.books.length : 0,
          itemBuilder: (context, i) {
            final book = this.books[i]; 

            return new FlatButton(
              padding: EdgeInsets.all(0.0),
              child: new BookListItem(book),
              onPressed: () {
                //Navigator.push(context, new MaterialPageRoute(builder: (context) => new DetailScreen(book: book,)));
              },
            );
          },
        );
  }
}

/*
 * BookListItem component. 
 */
class BookListItem extends StatelessWidget {
  final Book book;

  BookListItem(this.book);

  @override
  Widget build(BuildContext context) {
    final String title = book.title;
    final String description = book.description;
    final String imageUrl = book.imageUrl;
    final String publisher = book.publisher;
    final String weeksOnList = book.weeksOnList.toString();
    final String author = book.author;

    return new Container(
      padding: new EdgeInsets.all(16.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(imageUrl, width: 100.0,),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16.0, top: 12.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("$weeksOnList weeks on the list".toUpperCase(), style: TextStyle(fontSize: 12.0),),
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),  
                  Text("by $author | $publisher",),
                  new Container(height: 8.0,),
                  Text(description, style: TextStyle(fontFamily: 'georgia'),)
                ],
              ),
            ),
          ),
        ]
      )
    );
  }
  
}