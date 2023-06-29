import 'package:comicbookapp/core/network/http_client.dart';
import 'package:comicbookapp/home/data/data_sources/character_data_source.dart';
import 'package:comicbookapp/home/data/data_sources/issue_data_source.dart';
import 'package:comicbookapp/home/data/repositories/character_repository_impl.dart';
import 'package:comicbookapp/home/data/repositories/issue_repository_impl.dart';
import 'package:comicbookapp/home/domain/repositories/character_repository.dart';
import 'package:comicbookapp/home/domain/repositories/issue_repository.dart';
import 'package:get_it/get_it.dart';

class InjectorFactory {
  static const _format = 'json';

  static IssueRepository createIssueRepository() {
    try {
      return GetIt.I.get<IssueRepository>();
    } catch (_) {
      final dataSource = IssueDataSourceImpl(
          format: _format, client: GetIt.I.get<HttpClient>());
      final repository = IssueRepositoryImpl(dataSource: dataSource);
      GetIt.I.registerSingleton<IssueRepository>(repository);
      return repository;
    }
  }

  static CharacterRepository createCharacterRepository() {
    try {
      return GetIt.I.get<CharacterRepository>();
    } catch (_) {
      final dataSource = CharacterDataSourceImpl(
          format: _format, client: GetIt.I.get<HttpClient>());
      final repository =
          CharacterRepositoryImpl(characterDataSource: dataSource);
      GetIt.I.registerSingleton<CharacterRepository>(repository);
      return repository;
    }
  }
}
