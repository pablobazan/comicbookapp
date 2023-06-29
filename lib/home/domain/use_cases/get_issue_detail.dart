import 'package:comicbookapp/core/domain/comic_api_response.dart';
import 'package:comicbookapp/core/domain/use_case/use_case.dart';
import 'package:comicbookapp/core/error/failures.dart';
import 'package:comicbookapp/home/domain/entities/issue.dart';
import 'package:comicbookapp/home/domain/repositories/issue_repository.dart';
import 'package:dartz/dartz.dart';

class GetIssueDetailUseCase
    extends UseCase<ComicApiResponse<Issue>, ParamsGetIssueDetail> {
  final IssueRepository repository;

  GetIssueDetailUseCase({required this.repository});

  @override
  Future<Either<Failure, ComicApiResponse<Issue>>> call(
      ParamsGetIssueDetail params) async {
    return await repository.getIssueDetail(apiDetailUrl: params.apiDetailUrl);
  }
}

class ParamsGetIssueDetail {
  final String apiDetailUrl;

  ParamsGetIssueDetail({required this.apiDetailUrl});
}
