import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {

  final int id;
  final String imageUrl;

  const DetailScreen({
    Key key,
    @required this.id,
    @required this.imageUrl,
}):assert(id != null),
  assert(imageUrl != null),
  super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Hero(
          transitionOnUserGestures: true,
          tag: this.id,
          child: Image.network(
            imageUrl,
          ),
          placeholderBuilder: (context, widget) {
            return Container(
              height: 150.0,
              width: 150.0,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}