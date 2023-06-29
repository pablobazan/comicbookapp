import 'package:comicbookapp/core/domain/comic_api_response.dart';
import 'package:comicbookapp/home/domain/entities/character.dart';
import 'package:comicbookapp/home/domain/entities/issue.dart';
import 'package:comicbookapp/home/domain/use_cases/get_characters.dart';
import 'package:comicbookapp/home/domain/use_cases/get_issue_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comic_details_event.dart';
part 'comic_details_state.dart';

class ComicDetailsBloc extends Bloc<ComicDetailsEvent, ComicDetailsState> {
  final GetIssueDetailUseCase getIssueDetail;
  final GetCharactersUseCase getCharacters;
  ComicApiResponse<Issue>? issue;

  ComicDetailsBloc({required this.getIssueDetail, required this.getCharacters})
      : super(CharacterDetailsInitial(
          characters: const [],
          issue: Issue(apiDetailUrl: ''),
        )) {
    on<GetCharacterDetailsEvent>((event, emit) async {
      emit(CharacterDetailsLoading(
        characters: state.characters,
        issue: state.issue,
      ));
      final result = await getIssueDetail(
          ParamsGetIssueDetail(apiDetailUrl: event.apiDetailUrl));

      result.fold((failure) {
        emit(CharacterDetailsError(
          characters: state.characters,
          issue: state.issue,
        ));
      }, (comicResponse) {
        if (comicResponse.results == null) {
          emit(CharacterDetailsError(
            characters: state.characters,
            issue: state.issue,
          ));
          return;
        }
        issue = comicResponse;
        emit(CharacterDetailsLoaded(
            issue: comicResponse.results!, characters: const []));
      });

      final charactersUrlList =
          issue!.results!.characterCredits!.map((e) => e.apiDetailUrl).toList();

      final resultCharacters =
          await getCharacters(ParamsGetCharacters(urlList: charactersUrlList));

      resultCharacters.fold((failure) {}, (characters) {
        if (characters.isEmpty) return;
        emit(CharacterDetailsLoaded(
            issue: issue!.results!, characters: characters));
      });
    });
  }
}
