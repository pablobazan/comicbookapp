part of 'comic_details_bloc.dart';

abstract class ComicDetailsState extends Equatable {
  final Issue issue;
  final List<Character> characters;
  const ComicDetailsState({required this.issue, required this.characters});

  @override
  List<Object> get props => [issue, characters];
}

class CharacterDetailsInitial extends ComicDetailsState {
  const CharacterDetailsInitial(
      {required super.issue, required super.characters});
}

class CharacterDetailsLoading extends ComicDetailsState {
  const CharacterDetailsLoading(
      {required super.issue, required super.characters});
}

class CharacterDetailsLoaded extends ComicDetailsState {
  const CharacterDetailsLoaded(
      {required super.issue, required super.characters});
}

class CharacterDetailsError extends ComicDetailsState {
  const CharacterDetailsError(
      {required super.issue, required super.characters});
}
