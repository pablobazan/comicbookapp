import 'package:comicbookapp/core/error/failures.dart';
import 'package:comicbookapp/core/network/api_network.dart';
import 'package:comicbookapp/home/data/data_sources/character_data_source.dart';
import 'package:comicbookapp/home/domain/entities/character.dart';
import 'package:comicbookapp/home/domain/repositories/character_repository.dart';
import 'package:dartz/dartz.dart';

class CharacterRepositoryImpl extends CharacterRepository {
  final CharacterDataSource characterDataSource;

  CharacterRepositoryImpl({required this.characterDataSource});
  @override
  Future<Either<Failure, List<Character>>> getCharacters(
      {required List<String> urlList}) {
    return ApiNetwork.call<List<Character>>(() async {
      return await characterDataSource.getCharacters(urlList: urlList);
    });
  }
}
