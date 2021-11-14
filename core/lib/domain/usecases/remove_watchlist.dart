part of 'usecases.dart';

class RemoveWatchlist {
  final MovieRepository movieRepository;
  final TVSeriesRepository tvSeriesRepository;

  RemoveWatchlist(
    this.movieRepository,
    this.tvSeriesRepository,
  );

  Future<Either<Failure, String>> executeMovies(MovieDetail movie) {
    return movieRepository.removeWatchlist(movie);
  }

  Future<Either<Failure, String>> executeTVSeries(TVSeriesDetail tvSeries) {
    return tvSeriesRepository.removeWatchlist(tvSeries);
  }
}
