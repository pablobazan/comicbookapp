import 'package:comicbookapp/core/network/http_client.dart';
import 'package:comicbookapp/home/data/models/character_model.dart';
import 'package:comicbookapp/home/domain/entities/character.dart';

abstract class CharacterDataSource {
  Future<List<Character>> getCharacters({required List<String> urlList});
}

class CharacterDataSourceImpl implements CharacterDataSource {
  final HttpClient client;
  final String format;

  CharacterDataSourceImpl({required this.format, required this.client});

  @override
  Future<List<Character>> getCharacters({required List<String> urlList}) async {
    final data = {'format': format, 'field_list': 'name,image'};
    final List<Character> characters = [];

    await Future.forEach(urlList, (url) async {
      final character = await _getCharacter(url, data);
      characters.add(character);
    });

    return characters;
  }

  Future<Character> _getCharacter(
      String apiDetailUrl, Map<String, dynamic> data) async {
    final response = await client.get(apiDetailUrl, queryParameters: data);

    return CharacterModel.fromJson(response.data['results']);
  }
}
