part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetIssuesEvent extends HomeEvent {
  final int page;
  const GetIssuesEvent({required this.page});
}

class SwitchViewTypeEvent extends HomeEvent {
  final HomeViewType viewType;
  const SwitchViewTypeEvent({required this.viewType});
}
