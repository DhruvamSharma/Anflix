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

    return Hero(
        tag: this.id,
        child: Image.network(imageUrl),
    );
  }
}