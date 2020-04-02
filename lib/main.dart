import 'package:flutter/material.dart';
import 'screens/Home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(NYTBooksApp());
}

class NYTBooksApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    final appTitle = "NYT Books";

    return MaterialApp(
      title: appTitle, 
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      
      home: HomeScreen()
    );
  }
}
