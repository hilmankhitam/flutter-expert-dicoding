part of 'pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<NowPlayingMoviesBloc>()..add(FetchNowPlayingMovies());
    context.read<PopularMoviesBloc>()..add(FetchPopularMovies());
    context.read<TopRatedMoviesBloc>()..add(FetchTopRatedMovies());

    context.read<OnTheAirTVSeriesBloc>()..add(FetchOnTheAirTVSeries());
    context.read<PopularTVSeriesBloc>()..add(FetchPopularTVSeries());
    context.read<TopRatedTVSeriesBloc>()..add(FetchTopRatedTVSeries());
  }

  int currentIndex = 0;
  List bottomNavBarItems = [
    {
      'index': 0,
      'label': 'Movies',
      'icon': Icons.movie,
    },
    {
      'index': 1,
      'label': 'TV Series',
      'icon': Icons.tv,
    },
  ];

  Widget body() {
    switch (currentIndex) {
      case 0:
        return MoviePage();
      case 1:
        return TVSeriesPage();
      default:
        return MoviePage();
    }
  }

  Widget costumNavBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BottomAppBar(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: kRichBlack,
          selectedItemColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: bottomNavBarItems
              .map(
                (items) => BottomNavigationBarItem(
                  icon: Icon(
                    items['icon'],
                  ),
                  label: items['label'],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('packages/core/assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            Column(
              children: bottomNavBarItems
                  .map(
                    (items) => ListTile(
                      leading: Icon(items['icon']),
                      title: Text(items['label']),
                      onTap: () {
                        setState(() {
                          currentIndex = items['index'];
                        });
                        Navigator.pop(context);
                      },
                    ),
                  )
                  .toList(),
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchPage.ROUTE_NAME,
                arguments: currentIndex,
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: body(),
      bottomNavigationBar: costumNavBar(),
    );
  }
}
