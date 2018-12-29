import 'package:flutter/material.dart';
import 'package:popular_movies/src/ui/home/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Popular Movies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.black,
        brightness: Brightness.dark,
      ),
      home: HomeScreen(),
    );
  }

}