import 'package:flutter/material.dart';
import 'package:popular_movies/src/bloc/movies_bloc.dart';
import 'package:popular_movies/src/ui/home/home_screen_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var bloc = MoviesBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies',
        ),
        brightness: Brightness.dark,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.sort,
          color: Colors.white,
          ),
          onPressed: () {
            modalBottomSheetMenu();
          },
          )
        ],
      ),
      body: HomeScreenList(),
    );
  }

  modalBottomSheetMenu(){
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return new Container(
            height: double.infinity,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(onPressed: () {
                    bloc.fetchTopRatedMovies();
                  },
                  splashColor: Colors.red,),
                ),
            ),
          );
        }
    );
  }
}
