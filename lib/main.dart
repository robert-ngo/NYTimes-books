import 'package:flutter/material.dart';
import 'screens/Home.dart' as HomeScreen;

void main() => runApp(NYTBooksApp());

class NYTBooksApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    final appTitle = "NYT Books";

    return MaterialApp(
      title: appTitle, 
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomeScreen.HomeScreen(title: appTitle)
    );
  }
}
