import 'package:comicbookapp/core/domain/comic_api_response_list.dart';
import 'package:comicbookapp/core/domain/comic_api_response.dart';
import 'package:comicbookapp/core/network/api_paths.dart';
import 'package:comicbookapp/core/network/http_client.dart';
import 'package:comicbookapp/home/data/models/issue_model.dart';
import 'package:comicbookapp/home/domain/entities/issue.dart';

abstract class IssueDataSource {
  Future<ComicApiResponseList<Issue>> getIssues(
      {required int offset, required int limit});
  Future<ComicApiResponse<Issue>> getIssueDetail(
      {required String apiDetailUrl});
}

class IssueDataSourceImpl implements IssueDataSource {
  final HttpClient client;
  final String format;

  IssueDataSourceImpl({required this.format, required this.client});

  @override
  Future<ComicApiResponseList<Issue>> getIssues(
      {required int offset, required int limit}) async {
    final data = {
      'format': format,
      'limit': limit,
      'offset': offset,
      'sort': 'cover_date:desc',
      'field_list':
          'id,date_added,image,issue_number,name,api_detail_url,character_credits'
    };

    final response =
        await client.get(ApiPaths.issuePath, queryParameters: data);

    return ComicApiResponseList<Issue>.fromJson(
      response.data,
      (data) => IssueModel.fromJson(data),
    );
  }

  @override
  Future<ComicApiResponse<Issue>> getIssueDetail(
      {required String apiDetailUrl}) async {
    final data = {
      'format': format,
      'field_list': 'id,image,name,api_detail_url,character_credits'
    };
    final response = await client.get(apiDetailUrl, queryParameters: data);

    final comicApiResponse = ComicApiResponse<Issue>.fromJson(
        response.data, (data) => IssueModel.fromJson(data));

    return comicApiResponse;
  }
}
