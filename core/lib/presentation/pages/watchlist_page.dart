part of 'pages.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMoviesBloc>()..add(StartWatchlistMovies());
    context.read<WatchlistTVSeriesBloc>()..add(StartWatchlistTVSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesBloc>()..add(StartWatchlistMovies());
    context.read<WatchlistTVSeriesBloc>()..add(StartWatchlistTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Watchlist',
            style: kHeading5,
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.movie),
                text: 'Movies',
              ),
              Tab(
                icon: Icon(Icons.tv),
                text: 'TV Series',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WatchlistMoviesPage(),
            WatchlistTVSeriesPage(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class WatchlistMoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
          builder: (context, moviesState) {
        if (moviesState is WatchlistMoviesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (moviesState is WatchlistMoviesLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = moviesState.movies[index];
              return MovieCard(movie);
            },
            itemCount: moviesState.movies.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

class WatchlistTVSeriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
          builder: (context, tvSeriesState) {
        if (tvSeriesState is WatchlistTVSeriesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (tvSeriesState is WatchlistTVSeriesLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tvSeries = tvSeriesState.tvSeries[index];
              return TVSeriesCard(tvSeries);
            },
            itemCount: tvSeriesState.tvSeries.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
