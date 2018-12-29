import 'package:rxdart/rxdart.dart';
import 'package:popular_movies/src/models/item_model.dart';
import 'package:popular_movies/src/resources/repository/movies_repository.dart';

class MoviesBloc {

  final _moviesRepository = MoviesRepository();
  final _moviesFetcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    ItemModel model = await _moviesRepository.fetchAllMovies();
    _moviesFetcher.sink.add(model);
  }

  dispose() {
    _moviesFetcher.close();
  }

}

final bloc = MoviesBloc();