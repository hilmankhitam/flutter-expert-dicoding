part of 'pages.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedMoviesBloc>()..add(FetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
            builder: (context, moviesState) {
          if (moviesState is TopRatedMoviesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (moviesState is GetTopRatedMoviesState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = moviesState.movies[index];
                return MovieCard(movie);
              },
              itemCount: moviesState.movies.length,
            );
          } else if (moviesState is TopRatedMoviesError) {
            return Center(
              key: Key('error_message'),
              child: Text(moviesState.message),
            );
          } else {
            return Text('Failed');
          }
        }),
      ),
    );
  }
}
