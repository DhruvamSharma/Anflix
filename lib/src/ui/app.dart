import 'package:flutter/material.dart';
import 'package:popular_movies/src/ui/home/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Popular Movies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSans',
        brightness: Brightness.light,
        canvasColor: Colors.black,
        primaryColor: Colors.black
      ),
      home: HomeScreen(),
    );
  }

}