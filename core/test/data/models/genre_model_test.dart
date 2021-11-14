import 'dart:convert';

import 'package:core/core.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tGenreModel = GenreModel(
    id: 1,
    name: "Action",
  );
  final tGenreModelList = [tGenreModel];
  final tGenre = Genre(
    id: 1,
    name: "Action",
  );

  test('should be a subclass of genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });
  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // arrange

      // act
      final result = tGenreModel.toJson();
      // assert
      final expectedJsonMap = {"id": 1, "name": "Action"};
      expect(result, expectedJsonMap);
    });
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/genre.json'));
      // act
      final result = GenreModel.fromJson(jsonMap);
      // assert
      expect(result, tGenreModel);
    });
  });

  group('equatable', () {
    test('should equal', () {
      // arrange

      // act
      final result = [
        GenreModel(
          id: 1,
          name: "Action",
        ),
      ];
      // assert
      expect(result, tGenreModelList);
    });
  });
}
