part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();
}

class MovieTextChanged extends MovieSearchEvent {
  final String text;

  const MovieTextChanged({required this.text});

  @override
  List<Object> get props => [];
}
