import 'package:popular_movies/src/models/item_model.dart';

class Result {
  int _page;
  int _total_results;
  int _total_pages;
  List<ItemModel> _results = [];

  Result.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _total_results = parsedJson['total_results'];
    _total_pages = parsedJson['total_pages'];
    List<ItemModel> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      ItemModel result = ItemModel(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<ItemModel> get results => _results;

  int get total_pages => _total_pages;

  int get total_results => _total_results;

  int get page => _page;
}

