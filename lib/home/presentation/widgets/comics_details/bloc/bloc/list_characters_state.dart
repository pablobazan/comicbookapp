part of 'list_characters_bloc.dart';

abstract class ListCharactersState extends Equatable {
  const ListCharactersState({required this.characters});

  final List<Character> characters;

  @override
  List<Object> get props => [characters];
}

class ListCharactersInitial extends ListCharactersState {
  const ListCharactersInitial({required super.characters});
}

class ListCharactersLoading extends ListCharactersState {
  const ListCharactersLoading({required super.characters});
}

class ListCharactersLoaded extends ListCharactersState {
  const ListCharactersLoaded({required super.characters});
}

class ListCharactersError extends ListCharactersState {
  const ListCharactersError({required super.characters});
}

class ListCharactersEmpty extends ListCharactersState {
  const ListCharactersEmpty({required super.characters});
}
