part of 'pages.dart';

class TopRatedTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  _TopRatedTVSeriesPageState createState() => _TopRatedTVSeriesPageState();
}

class _TopRatedTVSeriesPageState extends State<TopRatedTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedTVSeriesBloc>()..add(FetchTopRatedTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
            builder: (context, tvSeriesState) {
          if (tvSeriesState is TopRatedTVSeriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (tvSeriesState is GetTopRatedTVSeriesState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = tvSeriesState.tvSeries[index];
                return TVSeriesCard(tvSeries);
              },
              itemCount: tvSeriesState.tvSeries.length,
            );
          } else if (tvSeriesState is TopRatedTVSeriesError) {
            return Center(
              key: Key('error_message'),
              child: Text(tvSeriesState.message),
            );
          } else {
            return Text('Failed');
          }
        }),
      ),
    );
  }
}
