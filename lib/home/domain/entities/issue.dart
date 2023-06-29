import 'package:comicbookapp/home/domain/entities/character_credit.dart';
import 'package:comicbookapp/home/domain/entities/image.dart';

class Issue {
  final String? dateAdded;

  final int? id;
  final Image? image;
  final String? issueNumber;
  final String? name;
  final List<CharacterCredit>? characterCredits;
  final String apiDetailUrl;

  Issue({
    this.dateAdded,
    this.id,
    this.image,
    this.issueNumber,
    this.name,
    this.characterCredits,
    required this.apiDetailUrl,
  });
}
