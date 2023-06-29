class CharacterCredit {
  String apiDetailUrl;
  int id;
  String name;
  String? siteDetailUrl;

  CharacterCredit({
    required this.apiDetailUrl,
    required this.id,
    required this.name,
    this.siteDetailUrl,
  });
}
