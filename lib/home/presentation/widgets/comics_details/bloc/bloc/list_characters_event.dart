part of 'list_characters_bloc.dart';

abstract class ListCharactersEvent extends Equatable {
  const ListCharactersEvent();

  @override
  List<Object> get props => [];
}

class ListCharactersInitialEvent extends ListCharactersEvent {
  const ListCharactersInitialEvent({required this.urlList});

  final List<String> urlList;
}
