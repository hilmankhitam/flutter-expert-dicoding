part of 'pages.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularMoviesBloc>()..add(FetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
            builder: (context, moviesState) {
          if (moviesState is PopularMoviesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (moviesState is GetPopularMoviesState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = moviesState.movies[index];
                return MovieCard(movie);
              },
              itemCount: moviesState.movies.length,
            );
          } else if (moviesState is PopularMoviesError) {
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
