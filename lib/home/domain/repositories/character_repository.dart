import 'package:comicbookapp/core/error/failures.dart';
import 'package:comicbookapp/home/domain/entities/character.dart';

import 'package:dartz/dartz.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getCharacters(
      {required List<String> urlList});
}
