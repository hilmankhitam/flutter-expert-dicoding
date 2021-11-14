part of 'usecases.dart';

class SaveWatchlist {
  final MovieRepository movieRepository;
  final TVSeriesRepository tvSeriesRepository;

  SaveWatchlist(
    this.movieRepository,
    this.tvSeriesRepository,
  );

  Future<Either<Failure, String>> executeMovies(MovieDetail movie) {
    return movieRepository.saveWatchlist(movie);
  }

  Future<Either<Failure, String>> executeTVSeries(TVSeriesDetail tvSeries) {
    return tvSeriesRepository.saveWatchlist(tvSeries);
  }
}
