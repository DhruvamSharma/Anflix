import 'package:flutter/material.dart';
import 'package:popular_movies/src/models/item_model.dart';

class DetailScreen extends StatelessWidget {

  final ItemModel model;

  const DetailScreen({
    Key key,
    @required this.model,
}):assert(model != null),
  super(key: key);

  @override
  Widget build(BuildContext context) {


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
                ),
                Text(model.release_date),
                Text(model.overview),
                Text(model.overview),
                Text(model.overview),
                Text(model.overview),
                Text(model.overview),
                Text(model.overview),
                similarMoviesGrid(model.genre_ids),
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

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 300.0, // TODO: check out later
            flexibleSpace: FlexibleSpaceBar(
              background: background,
            ),
          ),
          
          SliverList(delegate: SliverChildListDelegate(child))


        ],

      ),
    );





  }

  similarMoviesGrid(List<int> genre_ids) {
    //Code a Grid Widget here

  }




}