import 'package:comicbookapp/home/domain/entities/character.dart';
import 'package:comicbookapp/home/domain/use_cases/get_characters.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_characters_event.dart';
part 'list_characters_state.dart';

class ListCharactersBloc
    extends Bloc<ListCharactersEvent, ListCharactersState> {
  final GetCharactersUseCase getCharactersUseCase;

  ListCharactersBloc({required this.getCharactersUseCase})
      : super(const ListCharactersInitial(characters: [])) {
    on<ListCharactersInitialEvent>((event, emit) async {
      emit(ListCharactersLoading(characters: state.characters));

      final result = await getCharactersUseCase
          .call(ParamsGetCharacters(urlList: event.urlList));
      result.fold(
          (failure) => emit(ListCharactersError(characters: state.characters)),
          (characters) {
        if (characters.isEmpty) {
          emit(ListCharactersEmpty(characters: state.characters));
        } else {
          emit(ListCharactersLoaded(characters: characters));
        }
      });
    });
  }
}
