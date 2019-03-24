import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:popular_movies/src/models/result.dart';
import 'package:popular_movies/src/resources/repository/movies_repository.dart';

class MoviesBloc {

  final _moviesRepository = MoviesRepository();
  final _moviesFetcher = BehaviorSubject<Result>();

  Sink<Result> get allMovies => _fetcherController.sink;
  final _fetcherController = StreamController<Result>();

  Observable<Result> get newResults => _moviesFetcher.stream;

  fetchAllMovies()  {
    Future<dynamic> model = _moviesRepository.fetchAllMovies();
    if(model != null) {
      model.then((value) {
        print("adding all movies data to sink");
        allMovies.add(value);
      }).catchError((error) {
        allMovies.add(error);
      });
    } else {
    }
  }

  fetchTopRatedMovies() async{
    Result model = await _moviesRepository.fetchTopRatedMovies();
    print("adding top rated movies data to sink");
    allMovies.add(model);
  }

  dispose() {
    _moviesFetcher.close();
    _fetcherController.close();
  }

  MoviesBloc() {
    _fetcherController.stream.listen(_handle);
  }


  void _handle(Result event) {
    print("adding response to the sink");
    _moviesFetcher.add(event);
  }
}

final bloc = MoviesBloc();