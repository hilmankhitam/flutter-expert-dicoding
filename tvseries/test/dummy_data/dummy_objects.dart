import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';

final testTVSeries = TVSeries(
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

final testTVSeriesList = [testTVSeries];

final testEpisodeList = [
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
];

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

final tTVSeriesDetail = TVSeriesDetail(
    backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
    episodeRunTime: [60],
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
        // episodes: [
        //   Episode(
        //       airDate: "2021-09-17",
        //       episodeNumber: 1,
        //       id: 1922715,
        //       name: "Red Light, Green Light",
        //       overview:
        //           "Hoping to win easy money, a broke and desperate Gi-hun agrees to take part in an enigmatic game. Not long into the first round, unforeseen horrors unfold.",
        //       productionCode: "",
        //       seasonNumber: 1,
        //       stillPath: "/vMFJS9LIUUAmQ1thq4vJ7iHKwRz.jpg",
        //       voteAverage: 8.022,
        //       voteCount: 46)
        // ],
      )
    ],
    voteAverage: 8.3,
    voteCount: 11504);

final testWatchlistTVSeries = TVSeries.watchlist(
  id: 31917,
  overview:
      "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
  posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
  name: "Game of Thrones",
);

final testTVSeriesTable = TVSeriesTable(
  id: 31917,
  title: "Game of Thrones",
  posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
  overview:
      "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
  category: 'tvSeries',
);

final testTVSeriesMap = {
  'id': 31917,
  'overview':
      "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
  'posterPath': "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
  'title': "Game of Thrones",
  'category': 'tvSeries',
};
