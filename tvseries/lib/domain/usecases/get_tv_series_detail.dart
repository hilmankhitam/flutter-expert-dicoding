part of 'usecases.dart';

class GetTVSeriesDetail {
  final TVSeriesRepository repository;

  GetTVSeriesDetail(this.repository);

  Future<Either<Failure, TVSeriesDetail>> execute(int id) async {
    return repository.getTVSeriesDetail(id);
  }
}
