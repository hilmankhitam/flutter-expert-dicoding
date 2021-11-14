part of 'pages.dart';

class TVSeriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'On The Air',
              style: kHeading6,
            ),
            BlocBuilder<OnTheAirTVSeriesBloc, OnTheAirTVSeriesState>(
                builder: (context, tvSeriesState) {
              if (tvSeriesState is OnTheAirTVSeriesLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (tvSeriesState is GetOnTheAirTVSeriesState) {
                return TVSeriesList(tvSeriesState.tvSeries);
              } else {
                return Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTVSeriesPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularTVSeriesBloc, PopularTVSeriesState>(
                builder: (context, tvSeriesState) {
              if (tvSeriesState is PopularTVSeriesLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (tvSeriesState is GetPopularTVSeriesState) {
                return TVSeriesList(tvSeriesState.tvSeries);
              } else {
                return Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTVSeriesPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
                builder: (context, tvSeriesState) {
              if (tvSeriesState is TopRatedTVSeriesLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (tvSeriesState is GetTopRatedTVSeriesState) {
                return TVSeriesList(tvSeriesState.tvSeries);
              } else {
                return Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> tvSeries;

  TVSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSerie = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVSeriesDetailPage.ROUTE_NAME,
                  arguments: tvSerie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSerie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
