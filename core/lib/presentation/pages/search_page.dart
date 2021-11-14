part of 'pages.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  final int currentIndexNavBar;
  SearchPage({required this.currentIndexNavBar});

  Widget body(BuildContext context, int currentIndexNavBar) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (query) {
              if (currentIndexNavBar == 0) {
                context.read<MovieSearchBloc>()
                  ..add(MovieTextChanged(text: query));
              } else {
                context.read<TVSeriesSearchBloc>()
                  ..add(TVSeriesTextChanged(text: query));
              }
            },
            decoration: InputDecoration(
              hintText: 'Search title',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
          ),
          SizedBox(height: 16),
          Text(
            'Search Result',
            style: kHeading6,
          ),
          currentIndexNavBar == 0
              ? BlocBuilder<MovieSearchBloc, MovieSearchState>(
                  builder: (_, searchState) {
                    if (searchState is MovieSearchStateLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (searchState is MovieSearchStateSuccess) {
                      final result = searchState.movies;
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final movie = searchState.movies[index];
                            return MovieCard(movie);
                          },
                          itemCount: result.length,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Container(),
                      );
                    }
                  },
                )
              : BlocBuilder<TVSeriesSearchBloc, TVSeriesSearchState>(
                  builder: (_, searchState) {
                    if (searchState is TVSeriesSearchStateLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (searchState is TVSeriesSearchStateSuccess) {
                      final result = searchState.tvSeries;
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final tvSeries = searchState.tvSeries[index];
                            return TVSeriesCard(tvSeries);
                          },
                          itemCount: result.length,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Container(),
                      );
                    }
                  },
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: body(context, currentIndexNavBar),
    );
  }
}
