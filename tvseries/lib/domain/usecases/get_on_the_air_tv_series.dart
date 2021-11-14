part of 'usecases.dart';

class GetOnTheAirTVSeries {
  final TVSeriesRepository repository;

  GetOnTheAirTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getOnTheAirTVSeries();
  }
}
