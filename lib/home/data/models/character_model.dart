import 'package:comicbookapp/home/domain/entities/character.dart';
import 'package:comicbookapp/home/domain/entities/image.dart';

class CharacterModel extends Character {
  CharacterModel({super.name, super.image});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json['name'],
      image: Image.fromJson(json['image']),
    );
  }
}
