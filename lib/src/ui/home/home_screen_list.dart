import 'package:flutter/material.dart';
import 'package:popular_movies/src/bloc/movies_bloc.dart';
import 'package:popular_movies/src/ui/detail/detail.dart';
import '../../models/result.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreenList extends StatefulWidget {
  @override
  createState() => HomeScreenListState();
}

class HomeScreenListState extends State<HomeScreenList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final streamBuilder = StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
          if(snapshot.hasData) {
            return buildList(snapshot);
          } else if(snapshot.hasError) {
            return Text('Error!!');
          }

          return Center(
              child: CircularProgressIndicator(),
          );
        },
        stream: bloc.allMovies,
    );

    return streamBuilder;
  }



  Widget buildList(AsyncSnapshot<Result> snapshot) {

    var crossAxisCount;

    if(MediaQuery.of(context).orientation == Orientation.portrait) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 3;
    }

    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
        ),
        itemBuilder: (BuildContext context, int index) {
          if(index == 0) {
            crossAxisCount = 1;
          }
          return Hero(
            tag: snapshot.data.results[index].id,
            transitionOnUserGestures: true,
            child: GestureDetector(
              onTap: () {
                moveToDetailScreen(index, snapshot.data);
              },
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data
                    .results[index].poster_path}',
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }

  moveToDetailScreen(int index, Result model) {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return DetailScreen(
          model: model.results[index],
        );
      }),
    );
  }





}
