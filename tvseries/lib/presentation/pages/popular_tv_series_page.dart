part of 'pages.dart';

class PopularTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  _PopularTVSeriesPageState createState() => _PopularTVSeriesPageState();
}

class _PopularTVSeriesPageState extends State<PopularTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularTVSeriesBloc>()..add(FetchPopularTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTVSeriesBloc, PopularTVSeriesState>(
            builder: (context, tvSeriesState) {
          if (tvSeriesState is PopularTVSeriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (tvSeriesState is GetPopularTVSeriesState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = tvSeriesState.tvSeries[index];
                return TVSeriesCard(tvSeries);
              },
              itemCount: tvSeriesState.tvSeries.length,
            );
          } else if (tvSeriesState is PopularTVSeriesError) {
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
