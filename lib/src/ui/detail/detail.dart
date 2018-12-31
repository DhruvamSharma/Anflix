import 'package:flutter/material.dart';
import 'package:popular_movies/src/bloc/similar_movies_bloc.dart';
import 'package:popular_movies/src/models/item_model.dart';
import 'package:popular_movies/src/models/result.dart';

class DetailScreen extends StatelessWidget {

  final ItemModel model;

  const DetailScreen({
    Key key,
    @required this.model,
}):assert(model != null),
  super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = SimilarMoviesBloc();

    var loadingChild = <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              model.title,
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
            Text(model.release_date,
              style: TextStyle(color: Colors.green),
            ),
            Text(model.overview,
              style: TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('More Like this',
                style: TextStyle(fontSize: 16,
                    color: Colors.red),
              ),
            ),
            Center(
              child: CircularProgressIndicator(),
            )
            //similarMoviesGrid(model.genre_ids),
          ],
        ),
      ),
    ];

    var child = <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.title,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                ),
                Text(model.release_date,
                  style: TextStyle(color: Colors.green),
                ),
                Text(model.overview,
                style: TextStyle(color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('More Like this',
                  style: TextStyle(fontSize: 16,
                  color: Colors.red),
                  ),
                ),
                //similarMoviesGrid(model.genre_ids),
              ],
            ),
          ),
        ];

    var background = Hero(
      transitionOnUserGestures: true,
      tag: model.id,
      child: Image.network(
        'https://image.tmdb.org/t/p/w185${model
            .poster_path}',
        fit: BoxFit.fill,
        width: double.infinity,
        height: 300,
      ),
    );




    return FutureBuilder<Result>(
      builder: (BuildContext context, snapshot) {
        if(!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 300.0, // TODO: check out later
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(model.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    centerTitle: true,
                    background: background,
                  ),
                ),

                SliverList(delegate: SliverChildListDelegate(loadingChild)),
              ],

            ),
          );
        }

        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 300.0, // TODO: check out later
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(model.title),
                  centerTitle: true,
                  background: background,
                ),
              ),

              SliverList(delegate: SliverChildListDelegate(child)),
              _mySimilarMovies(snapshot.data),
            ],

          ),
        );
      },
      future: bloc.fetchAllMovies(model.genre_ids),

    );

  }

  SliverGrid _mySimilarMovies(Result data) {

    return SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network('https://image.tmdb.org/t/p/w185${data
                .results[index].poster_path}',
              fit: BoxFit.cover,
            ),
          );
        },
        childCount: data.results.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );



  }




}