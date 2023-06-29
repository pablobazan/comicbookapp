import 'package:comicbookapp/core/domain/comic_api_response.dart';
import 'package:comicbookapp/core/domain/comic_api_response_list.dart';
import 'package:comicbookapp/core/error/failures.dart';
import 'package:comicbookapp/core/network/api_network.dart';
import 'package:comicbookapp/home/data/data_sources/issue_data_source.dart';
import 'package:comicbookapp/home/domain/entities/issue.dart';
import 'package:comicbookapp/home/domain/repositories/issue_repository.dart';
import 'package:dartz/dartz.dart';

class IssueRepositoryImpl extends IssueRepository {
  final IssueDataSource dataSource;

  IssueRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, ComicApiResponseList<Issue>>> getIssues(
      {required int offset, required int limit}) async {
    return ApiNetwork.call<ComicApiResponseList<Issue>>(() async {
      return await dataSource.getIssues(limit: limit, offset: offset);
    });
  }

  @override
  Future<Either<Failure, ComicApiResponse<Issue>>> getIssueDetail(
      {required String apiDetailUrl}) {
    return ApiNetwork.call<ComicApiResponse<Issue>>(() async {
      return await dataSource.getIssueDetail(apiDetailUrl: apiDetailUrl);
    });
  }
}
