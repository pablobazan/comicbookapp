import 'package:comicbookapp/home/domain/use_cases/get_issues.dart';
import 'package:comicbookapp/home/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:comicbookapp/core/domain/comic_api_response_list.dart';
import 'package:comicbookapp/home/domain/entities/issue.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetIssuesUseCase getIssuesUseCase;
  final int limit = 10;

  HomeBloc({required this.getIssuesUseCase})
      : super(HomeInitialState(
            ComicApiResponseList<Issue>(results: []), HomeViewType.grid)) {
    on<GetIssuesEvent>(getIssues);

    on<SwitchViewTypeEvent>((event, emit) {
      emit(HomeLoadedState(state.issues, event.viewType));
    });
  }

  Future<void> getIssues(GetIssuesEvent event, Emitter<HomeState> emit) async {
    if (state.issues!.results.isEmpty) {
      emit(HomeLoadingState(state.issues, state.viewType));
    }

    final result = await getIssuesUseCase(
        ParamsGetIssues(limit: limit, offset: (event.page - 1) * limit));
    return result.fold((failure) {
      emit(HomeErrorState(state.issues, HomeViewType.list));
    }, (issues) {
      if (issues.results.isEmpty) {
        emit(HomeEmptyState(issues, state.viewType));
      } else {
        if (state.issues!.results.isEmpty) {
          emit(HomeLoadedState(issues, state.viewType));
          return;
        }

        ComicApiResponseList<Issue> newIssueList = state.issues!
            .copyWith(results: state.issues!.results + issues.results);

        emit(HomeLoadedState(newIssueList, state.viewType));
      }
    });
  }
}
