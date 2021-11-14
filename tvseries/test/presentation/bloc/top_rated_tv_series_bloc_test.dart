import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late TopRatedTVSeriesBloc topRatedTVSeriesBloc;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    topRatedTVSeriesBloc =
        TopRatedTVSeriesBloc(getTopRatedTVSeries: mockGetTopRatedTVSeries);
  });

  test('initial state should be loading', () {
    expect(topRatedTVSeriesBloc.state, TopRatedTVSeriesLoading());
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

  blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      return topRatedTVSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTVSeries()),
    expect: () => [
      TopRatedTVSeriesLoading(),
      GetTopRatedTVSeriesState(tTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTVSeries.execute());
    },
  );

  blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTVSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTVSeries()),
    expect: () => [
      TopRatedTVSeriesLoading(),
      TopRatedTVSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTVSeries.execute());
    },
  );
}
