part of 'usecases.dart';

class GetSeasonDetail {
  final TVSeriesRepository repository;

  GetSeasonDetail(this.repository);

  Future<Either<Failure, List<Episode>>> execute(
      int idTVSeries, int seasonNumber) {
    return repository.getSeasonDetail(idTVSeries, seasonNumber);
  }
}
