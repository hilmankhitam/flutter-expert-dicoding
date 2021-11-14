import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late TVSeriesSearchBloc tvSeriesSearchBloc;
  late MockSearchTVSeries mockSearchTVSeries;

  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    tvSeriesSearchBloc = TVSeriesSearchBloc(searchTVSeries: mockSearchTVSeries);
  });

  test('initial state should be empty', () {
    expect(tvSeriesSearchBloc.state, TVSeriesSearchStateEmpty());
  });

  final tTVSeriesModel = TVSeries(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originCountry: ["US"],
    genreIds: [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    originalName: "Pretty Little Liars",
  );
  final tTVSeriesList = <TVSeries>[tTVSeriesModel];
  final tQuery = 'pretty';

  blocTest<TVSeriesSearchBloc, TVSeriesSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTVSeriesList));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(TVSeriesTextChanged(text: tQuery)),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      TVSeriesSearchStateLoading(),
      TVSeriesSearchStateSuccess(tTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
    },
  );

  blocTest<TVSeriesSearchBloc, TVSeriesSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(TVSeriesTextChanged(text: tQuery)),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      TVSeriesSearchStateLoading(),
      TVSeriesSearchStateError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
    },
  );
}
