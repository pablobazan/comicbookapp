import 'package:comicbookapp/home/data/models/character_credit_model.dart';
import 'package:comicbookapp/home/domain/entities/image.dart';
import 'package:comicbookapp/home/domain/entities/issue.dart';

class IssueModel extends Issue {
  IssueModel({
    super.dateAdded,
    super.id,
    super.image,
    super.issueNumber,
    super.name,
    super.characterCredits,
    required super.apiDetailUrl,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      dateAdded: json['date_added'],
      id: json['id'],
      image: Image.fromJson(json['image']),
      issueNumber: json['issue_number'],
      name: json['name'],
      apiDetailUrl: json['api_detail_url'],
      characterCredits: json['character_credits'] != null
          ? (json['character_credits'] as List)
              .map((e) => CharacterCreditModel.fromJson(e))
              .toList()
          : null,
    );
  }
}
