part of 'tv_series_search_bloc.dart';

abstract class TVSeriesSearchEvent extends Equatable {
  const TVSeriesSearchEvent();
}

class TVSeriesTextChanged extends TVSeriesSearchEvent {
  final String text;

  const TVSeriesTextChanged({required this.text});

  @override
  List<Object> get props => [];
}
