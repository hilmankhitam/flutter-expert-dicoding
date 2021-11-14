import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:tvseries/tvseries.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationsMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationsTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTVSeriesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Ditonton',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(
            secondary: kMikadoYellow,
          ),
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(
                builder: (_) => HomePage(),
              );
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => PopularMoviesPage(),
              );
            case PopularTVSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => PopularTVSeriesPage(),
              );
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => TopRatedMoviesPage(),
              );
            case TopRatedTVSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => TopRatedTVSeriesPage(),
              );
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(
                  id: id,
                ),
                settings: settings,
              );
            case TVSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVSeriesDetailPage(
                  id: id,
                ),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              final currentIndexNavBar = settings.arguments as int;
              return CupertinoPageRoute(
                builder: (_) => SearchPage(
                  currentIndexNavBar: currentIndexNavBar,
                ),
              );
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => WatchlistPage(),
              );
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => AboutPage(),
              );
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
