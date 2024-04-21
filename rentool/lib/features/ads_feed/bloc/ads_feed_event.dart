// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ads_feed_bloc.dart';

@immutable
sealed class AdsFeedEvent extends Equatable {
  const AdsFeedEvent();

  @override
  List<Object> get props => [];
}

class AdsFeedLoadEvent extends AdsFeedEvent {
  const AdsFeedLoadEvent({
    this.completer,
  });
  final Completer? completer;
}
