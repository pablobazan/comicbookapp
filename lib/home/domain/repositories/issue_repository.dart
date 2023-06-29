import 'package:comicbookapp/core/domain/comic_api_response.dart';
import 'package:comicbookapp/core/domain/comic_api_response_list.dart';
import 'package:comicbookapp/core/error/failures.dart';
import 'package:comicbookapp/home/domain/entities/issue.dart';
import 'package:dartz/dartz.dart';

abstract class IssueRepository {
  Future<Either<Failure, ComicApiResponseList<Issue>>> getIssues(
      {required int offset, required int limit});
  Future<Either<Failure, ComicApiResponse<Issue>>> getIssueDetail(
      {required String apiDetailUrl});
}
