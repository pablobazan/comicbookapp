import 'package:comicbookapp/core/domain/use_case/use_case.dart';
import 'package:comicbookapp/core/error/failures.dart';
import 'package:comicbookapp/home/domain/entities/character.dart';
import 'package:comicbookapp/home/domain/repositories/character_repository.dart';
import 'package:dartz/dartz.dart';

class GetCharactersUseCase
    extends UseCase<List<Character>, ParamsGetCharacters> {
  final CharacterRepository repository;

  GetCharactersUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Character>>> call(
      ParamsGetCharacters params) async {
    return await repository.getCharacters(urlList: params.urlList);
  }
}

class ParamsGetCharacters {
  final List<String> urlList;

  ParamsGetCharacters({required this.urlList});
}
