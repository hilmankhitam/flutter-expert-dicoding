part of 'pages.dart';

class TVSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv-series';

  final int id;
  TVSeriesDetailPage({required this.id});

  @override
  _TVSeriesDetailPageState createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVSeriesDetailBloc>()..add(FetchTVSeriesDetail(widget.id));
      context.read<WatchlistTVSeriesBloc>()
        ..add(LoadWatchlistTVSeriesStatus(widget.id));
      context.read<RecommendationsTVSeriesBloc>()
        ..add(FetchRecommendations(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TVSeriesDetailBloc, TVSeriesDetailState>(
          builder: (context, tvSeriesState) {
        if (tvSeriesState is TVSeriesDetailLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (tvSeriesState is GetTVSeriesDetailState) {
          final tvSeries = tvSeriesState.tvSeries;
          return SafeArea(
            child: DetailContent(
              tvSeries,
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
  final TVSeriesDetail tvSeries;

  DetailContent(
    this.tvSeries,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
              ),
            ),
          ),
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          width: screenWidth,
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
                              tvSeries.name!,
                              style: kHeading5,
                            ),
                            BlocBuilder<WatchlistTVSeriesBloc,
                                WatchlistTVSeriesState>(
                              builder: (_, state) {
                                if (state is GetWatchlistTVSeriesStatus) {
                                  bool isAddedToWatchlist = state.status;
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (isAddedToWatchlist) {
                                        context
                                            .read<WatchlistTVSeriesBloc>()
                                            .add(RemoveWatchlistTVSeries(
                                                tvSeries));

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Removed from Watchlist')));
                                      } else {
                                        context
                                            .read<WatchlistTVSeriesBloc>()
                                            .add(
                                                AddWatchlistTVSeries(tvSeries));
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
                              _showGenres(tvSeries.genres!),
                            ),
                            Text(
                              _showDuration(tvSeries.episodeRunTime!),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeries.overview!,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            Column(
                              children: tvSeries.seasons!.map((season) {
                                return ExpansionTile(
                                  leading: season.posterPath != null
                                      ? Image.network(
                                          'https://image.tmdb.org/t/p/w500${season.posterPath}',
                                          fit: BoxFit.cover,
                                          errorBuilder: (c, o, s) {
                                            print(
                                                'Load failed : ${c.toString()}');
                                            return const Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            );
                                          },
                                        )
                                      : Icon(Icons.tv),
                                  title: Text(
                                    season.name,
                                    style: kHeading6.copyWith(
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text(
                                    season.overview,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: kSubtitle,
                                  ),
                                  children: season.episodes!
                                      .map(
                                        (episode) => ListTile(
                                          leading: episode.stillPath != null
                                              ? Image.network(
                                                  'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (c, o, s) {
                                                    print(
                                                        'Load failed : ${c.toString()}');
                                                    return const Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                    );
                                                  },
                                                )
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                    left: 20,
                                                  ),
                                                  child: Icon(
                                                    Icons.tv,
                                                    size: 20,
                                                  ),
                                                ),
                                          title: Text(
                                            episode.name!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: kHeading5.copyWith(
                                              fontSize: 16,
                                            ),
                                          ),
                                          subtitle: Text(
                                            episode.overview!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: kBodyText,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationsTVSeriesBloc,
                                    RecommendationsTVSeriesState>(
                                builder: (context, tvSeriesState) {
                              if (tvSeriesState is RecommendationLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (tvSeriesState
                                  is RecommendationTVSeriesError) {
                                return Text(tvSeriesState.message);
                              } else if (tvSeriesState
                                  is GetRecommendationTVSeriesState) {
                                return Container(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final movie =
                                          tvSeriesState.tvSeries[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              TVSeriesDetailPage.ROUTE_NAME,
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
                                    itemCount: tvSeriesState.tvSeries.length,
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
        ),
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

  String _showDuration(List<int> runtime) {
    var durations = runtime.map((e) {
      final int hours = e ~/ 60;
      final int minutes = e % 60;

      if (hours > 0) {
        return '${hours}h ${minutes}m';
      } else {
        return '${minutes}m';
      }
    }).toList();

    String result = '';

    for (var duration in durations) {
      result += duration + (duration != durations.last ? ', ' : '');
    }
    return result;
  }
}
