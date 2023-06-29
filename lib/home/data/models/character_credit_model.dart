import 'package:comicbookapp/home/domain/entities/character_credit.dart';

class CharacterCreditModel extends CharacterCredit {
  CharacterCreditModel({
    required int id,
    required String name,
    required String apiDetailUrl,
    String? siteDetailUrl,
  }) : super(
          id: id,
          name: name,
          apiDetailUrl: apiDetailUrl,
          siteDetailUrl: siteDetailUrl,
        );

  factory CharacterCreditModel.fromJson(Map<String, dynamic> json) {
    return CharacterCreditModel(
      apiDetailUrl: json['api_detail_url'],
      id: json['id'],
      name: json['name'],
      siteDetailUrl: json['site_detail_url'],
    );
  }
}
