import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

// 1. add Book data model 
class Book {
  final String title;
  final String imageUrl;
  final String publisher;
  final String weeksOnList;
  final String author;

  Book({this.title, this.imageUrl, this.publisher, this.weeksOnList, this.author});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      imageUrl: json['book_image'],
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
class HomeScreen extends StatelessWidget {
  final String title;

  HomeScreen({Key key, @required this.title}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.title),
      ),
      body: FutureBuilder<List<Book>>(
        future: fetchBooks(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print (snapshot.error);

          return snapshot.hasError 
            ? Center(child: CircularProgressIndicator())
            : BookList(books: snapshot.data) ;
        },
      )
    );
  }
}

/*
 * BookList componenent. 
 * Render List<Book> as a grid of 2 columns.
 */
class BookList extends StatelessWidget {
  final List<Book> books;

  BookList({Key key, this.books}) : super(key: key);

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