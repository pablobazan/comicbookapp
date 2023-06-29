import 'package:comicbookapp/core/domain/comic_api_response_list.dart';
import 'package:comicbookapp/core/domain/use_case/use_case.dart';
import 'package:comicbookapp/core/error/failures.dart';
import 'package:comicbookapp/home/domain/entities/issue.dart';
import 'package:comicbookapp/home/domain/repositories/issue_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetIssuesUseCase
    extends UseCase<ComicApiResponseList<Issue>, ParamsGetIssues> {
  final IssueRepository repository;

  GetIssuesUseCase({required this.repository});

  @override
  Future<Either<Failure, ComicApiResponseList<Issue>>> call(
      ParamsGetIssues params) async {
    return await repository.getIssues(
        limit: params.limit, offset: params.offset);
  }
}

class ParamsGetIssues extends Equatable {
  final int offset;
  final int limit;

  const ParamsGetIssues({required this.offset, required this.limit});

  @override
  List<Object?> get props => [offset, limit];
}
