import 'package:flutter/material.dart';
import 'package:popular_movies/src/bloc/movies_bloc.dart';
import 'package:popular_movies/src/ui/detail/detail.dart';
import '../../models/item_model.dart';
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
  Widget build(BuildContext context) {

    final grid = GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16),

      children: <Widget>[
        Text("MyData"),
        Text("My data again"),
      ],
    );


    final streamBuilder = StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
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

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          if(index == 0 || index == 1) {
            return Text("Start");
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

  moveToDetailScreen(int index, ItemModel model) {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return DetailScreen(
          id: model.results[index].id,
          imageUrl: 'https://image.tmdb.org/t/p/w185${model.results[index].poster_path}',
        );
      }),
    );
  }


}
