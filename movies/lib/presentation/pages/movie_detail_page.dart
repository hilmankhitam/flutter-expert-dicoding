part of 'pages.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-movie';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>()..add(FetchMovieDetail(widget.id));
      context.read<WatchlistMoviesBloc>()
        ..add(LoadWatchlistMovieStatus(widget.id));
      context.read<RecommendationsMovieBloc>()
        ..add(FetchRecommendations(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, moviesState) {
        if (moviesState is MovieDetailLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (moviesState is GetMovieDetailState) {
          final movie = moviesState.movie;
          return SafeArea(
            child: DetailContent(
              movie,
            ),
          );
        } else {
          return Text('Failed');
        }
      }),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;

  DetailContent(
    this.movie,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            BlocBuilder<WatchlistMoviesBloc,
                                WatchlistMoviesState>(
                              builder: (_, state) {
                                if (state is GetWatchlistMovieStatus) {
                                  bool isAddedToWatchlist = state.status;
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (isAddedToWatchlist) {
                                        context
                                            .read<WatchlistMoviesBloc>()
                                            .add(RemoveWatchlistMovie(movie));

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Removed from Watchlist')));
                                      } else {
                                        context
                                            .read<WatchlistMoviesBloc>()
                                            .add(AddWatchlistMovie(movie));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Added to Watchlist')));
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        isAddedToWatchlist
                                            ? Icon(Icons.check)
                                            : Icon(Icons.add),
                                        Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                    height: 48,
                                  );
                                }
                              },
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationsMovieBloc,
                                    RecommendationsMovieState>(
                                builder: (context, moviesState) {
                              if (moviesState is RecommendationLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (moviesState
                                  is RecommendationMoviesError) {
                                return Text(moviesState.message);
                              } else if (moviesState
                                  is GetRecommendationMoviesState) {
                                return Container(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final movie = moviesState.movies[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              MovieDetailPage.ROUTE_NAME,
                                              arguments: movie.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: moviesState.movies.length,
                                  ),
                                );
                              } else {
                                return Text('Failed');
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
