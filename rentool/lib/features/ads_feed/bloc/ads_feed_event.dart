// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ads_feed_bloc.dart';

@immutable
sealed class AdsFeedEvent extends Equatable {
  const AdsFeedEvent();

  @override
  List<Object?> get props => [];
}

class AdsFeedLoadEvent extends AdsFeedEvent {
  const AdsFeedLoadEvent({
    this.completer,
    this.page = 0,
    this.size = 5,
  });
  final int page;
  final int size;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..addAll([completer, page, size]);
}

class AdsFeedToggleFavoriteToolEvent extends AdsFeedEvent {
  const AdsFeedToggleFavoriteToolEvent({
    required this.tool,
    this.completer,
  });

  final Tool tool;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..addAll([tool, completer]);
}
