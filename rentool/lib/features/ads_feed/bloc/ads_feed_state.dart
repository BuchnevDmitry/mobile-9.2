part of 'ads_feed_bloc.dart';

@immutable
sealed class AdsFeedState extends Equatable {
  const AdsFeedState();

  @override
  List<Object> get props => [];
}

final class AdsFeedInitialState extends AdsFeedState {}

final class AdsFeedLoadingState extends AdsFeedState {}

final class AdsFeedLoadedState extends AdsFeedState {
  const AdsFeedLoadedState({required this.tools});

  final Tools tools;

  @override
  List<Object> get props => super.props..add(tools);
}

final class AdsFeedLoadingFailureState extends AdsFeedState {
  const AdsFeedLoadingFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
