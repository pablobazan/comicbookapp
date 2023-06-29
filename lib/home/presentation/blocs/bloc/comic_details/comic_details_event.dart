part of 'comic_details_bloc.dart';

abstract class ComicDetailsEvent extends Equatable {
  const ComicDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetCharacterDetailsEvent extends ComicDetailsEvent {
  final String apiDetailUrl;

  const GetCharacterDetailsEvent({required this.apiDetailUrl});

  @override
  List<Object> get props => [apiDetailUrl];
}
