part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState(this.issues, this.viewType);

  final ComicApiResponseList<Issue>? issues;
  final HomeViewType viewType;

  @override
  List<dynamic> get props => [issues, viewType];
}

class HomeInitialState extends HomeState {
  const HomeInitialState(issues, viewType) : super(issues, viewType);
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState(issues, viewType) : super(issues, viewType);
}

class HomeLoadedState extends HomeState {
  const HomeLoadedState(issues, viewType) : super(issues, viewType);
}

class HomeErrorState extends HomeState {
  const HomeErrorState(issues, viewType) : super(issues, viewType);
}

class HomeEmptyState extends HomeState {
  const HomeEmptyState(issues, viewType) : super(issues, viewType);
}
