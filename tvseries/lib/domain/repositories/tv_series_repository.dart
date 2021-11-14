import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/entities.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getOnTheAirTVSeries();
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries();
  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries();
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query);
  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id);
  Future<Either<Failure, List<TVSeries>>> getTVSeriesRecommendations(int id);
  Future<Either<Failure, List<Episode>>> getSeasonDetail(
      int idTVSeries, int seasonNumber);
  Future<Either<Failure, String>> saveWatchlist(TVSeriesDetail tvSeries);
  Future<Either<Failure, String>> removeWatchlist(TVSeriesDetail tvSeries);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TVSeries>>> getWatchlistTVSeries();
}
