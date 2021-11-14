import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeriesDetail, GetSeasonDetail])
void main() {
  late TVSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late MockGetSeasonDetail mockGetSeasonDetail;

  setUp(() {
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    mockGetSeasonDetail = MockGetSeasonDetail();
    tvSeriesDetailBloc = TVSeriesDetailBloc(
      getTVSeriesDetail: mockGetTVSeriesDetail,
      getSeasonDetail: mockGetSeasonDetail,
    );
  });

  test('initial state should be loading', () {
    expect(tvSeriesDetailBloc.state, TVSeriesDetailLoading());
  });

  final tTVSeriesDetail = TVSeriesDetail(
      backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
      episodeRunTime: [60, 58],
      genres: [Genre(id: 1, name: 'Action')],
      id: 31917,
      name: "Game of Thrones",
      originalName: "Game of Thrones",
      overview:
          "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
      posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
      seasons: [
        Season(
            airDate: "2010-12-05",
            episodeCount: 64,
            id: 3627,
            name: "Specials",
            overview: "",
            posterPath: "/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg",
            seasonNumber: 0,
            episodes: [])
      ],
      voteAverage: 8.3,
      voteCount: 11504);

  final tEpisode = Episode(
      airDate: "2021-09-17",
      episodeNumber: 1,
      id: 1922715,
      name: "Red Light, Green Light",
      overview:
          "Hoping to win easy money, a broke and desperate Gi-hun agrees to take part in an enigmatic game. Not long into the first round, unforeseen horrors unfold.",
      productionCode: "",
      seasonNumber: 1,
      stillPath: "/vMFJS9LIUUAmQ1thq4vJ7iHKwRz.jpg",
      voteAverage: 8.022,
      voteCount: 46);

  final tEpisodeList = [tEpisode];

  final testTVSeriesDetail = TVSeriesDetail(
      backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
      episodeRunTime: [60, 58],
      genres: [Genre(id: 1, name: 'Action')],
      id: 31917,
      name: "Game of Thrones",
      originalName: "Game of Thrones",
      overview:
          "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
      posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
      seasons: [
        Season(
            airDate: "2010-12-05",
            episodeCount: 64,
            id: 3627,
            name: "Specials",
            overview: "",
            posterPath: "/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg",
            seasonNumber: 0,
            episodes: [
              Episode(
                  airDate: "2021-09-17",
                  episodeNumber: 1,
                  id: 1922715,
                  name: "Red Light, Green Light",
                  overview:
                      "Hoping to win easy money, a broke and desperate Gi-hun agrees to take part in an enigmatic game. Not long into the first round, unforeseen horrors unfold.",
                  productionCode: "",
                  seasonNumber: 1,
                  stillPath: "/vMFJS9LIUUAmQ1thq4vJ7iHKwRz.jpg",
                  voteAverage: 8.022,
                  voteCount: 46)
            ])
      ],
      voteAverage: 8.3,
      voteCount: 11504);

  final tId = 31917;
  final tSeasonNumber = 0;

  blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(tTVSeriesDetail));
      when(mockGetSeasonDetail.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(tEpisodeList));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTVSeriesDetail(tId)),
    expect: () => [
      TVSeriesDetailLoading(),
      GetTVSeriesDetailState(testTVSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetTVSeriesDetail.execute(tId));
    },
  );

  blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
    'Should emit [Loading, Error] when get detail is unsuccessful',
    build: () {
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTVSeriesDetail(tId)),
    expect: () => [
      TVSeriesDetailLoading(),
      TVSeriesDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVSeriesDetail.execute(tId));
    },
  );
}
