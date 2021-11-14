part of 'usecases.dart';

class GetWatchListStatus {
  final MovieRepository movieRepository;
  final TVSeriesRepository tvSeriesRepository;

  GetWatchListStatus(
    this.movieRepository,
    this.tvSeriesRepository,
  );

  Future<bool> executeMovies(int id) async {
    return movieRepository.isAddedToWatchlist(id);
  }

  Future<bool> executeTVSeries(int id) async {
    return tvSeriesRepository.isAddedToWatchlist(id);
  }
}
