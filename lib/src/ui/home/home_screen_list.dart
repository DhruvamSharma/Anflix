import 'package:flutter/material.dart';
import 'package:popular_movies/src/bloc/movies_bloc.dart';
import 'package:popular_movies/src/ui/detail/detail.dart';
import '../../models/result.dart';

class HomeScreenList extends StatefulWidget {

  final GestureTapCallback callback;

  HomeScreenList({@required this.callback}): assert(callback != null);

  @override
  createState() => HomeScreenListState(callback);
}

class HomeScreenListState extends State<HomeScreenList> {

  final GestureTapCallback callback;

  HomeScreenListState(this.callback);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
        if(snapshot.hasData) {
          print("now here");
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
  }


  @override
  void didUpdateWidget(HomeScreenList oldWidget) {
    super.didUpdateWidget(oldWidget);


    setState((){
      print("new state");
    });

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
