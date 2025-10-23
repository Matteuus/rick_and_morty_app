import 'package:rick_and_morty_app/model/character_model.dart';

class CharacterResponse {
  final List<CharacterModel> results;
  final int pages;
  final String? next;

  CharacterResponse({
    required this.results,
    required this.pages,
    required this.next,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List)
        .map((item) => CharacterModel.fromJson(item))
        .toList();
    final info = json['info'];
    return CharacterResponse(
      results: results,
      pages: info['pages'],
      next: info['next'],
    );
  }
}
