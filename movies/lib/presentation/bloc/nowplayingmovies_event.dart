part of 'nowplayingmovies_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();
}

class FetchNowPlayingMovies extends NowPlayingMoviesEvent {
  @override
  List<Object> get props => [];
}
