import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:tvseries/data/models/models.dart';

abstract class TVSeriesRemoteDataSource {
  Future<List<TVSeriesModel>> getOnTheAirTVSeries();
  Future<List<TVSeriesModel>> getPopularTVSeries();
  Future<List<TVSeriesModel>> getTopRatedTVSeries();
  Future<List<TVSeriesModel>> searchTVSeries(String query);
  Future<TVSeriesDetailResponse> getTVSeriesDetail(int id);
  Future<List<TVSeriesModel>> getTVSeriesRecommendations(int id);
  Future<List<EpisodeModel>> getSeasonDetail(int idTVSeries, int seasonNumber);
}

class TVSeriesRemoteDataSourceImpl implements TVSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TVSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVSeriesModel>> getOnTheAirTVSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getPopularTVSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getTopRatedTVSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> searchTVSeries(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVSeriesDetailResponse> getTVSeriesDetail(int id) async {
    final responseTVSeriesDetail =
        await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));
    if (responseTVSeriesDetail.statusCode == 200) {
      return TVSeriesDetailResponse.fromJson(
          json.decode(responseTVSeriesDetail.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getTVSeriesRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<EpisodeModel>> getSeasonDetail(
      int idTVSeries, int seasonNumber) async {
    final response = await client.get(
        Uri.parse('$BASE_URL/tv/$idTVSeries/season/$seasonNumber?$API_KEY'));
    if (response.statusCode == 200) {
      return SeasonDetailModelResponse.fromJson(json.decode(response.body))
          .episodes;
    } else {
      throw ServerException();
    }
  }
}
