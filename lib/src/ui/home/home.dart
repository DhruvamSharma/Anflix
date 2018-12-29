import 'package:flutter/material.dart';
import 'package:popular_movies/src/ui/home/home_screen_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
        brightness: Brightness.dark,
        centerTitle: true,
      ),
      body: HomeScreenList(),
    );
  }
}
