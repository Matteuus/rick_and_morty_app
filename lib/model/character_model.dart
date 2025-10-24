class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String origin;
  final String image;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.origin,
    required this.image,
  });

  CharacterModel copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? gender,
    String? origin,
    String? image,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      gender: gender ?? this.gender,
      origin: origin ?? this.origin,
      image: image ?? this.image,
    );
  }

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      origin: json['origin']['name'],
      image: json['image'],
    );
  }

  String get translatedStatus {
    switch (status.toLowerCase()) {
      case 'alive':
        return 'Vivo';
      case 'dead':
        return 'Morto';
      case 'unknown':
        return 'Desconhecido';
      default:
        return status;
    }
  }

  String get translatedSpecies {
    switch (species.toLowerCase()) {
      case 'human':
        return 'Humano';
      case 'alien':
        return 'Alienígena';
      case 'mythological creature':
        return 'Criatura Mitológica';
      default:
        return species;
    }
  }

  String get translatedGender {
    switch (gender.toLowerCase()) {
      case 'male':
        return 'Masculino';
      case 'female':
        return 'Feminino';
      case 'genderless':
        return 'Sem gênero';
      case 'unknown':
        return 'Desconhecido';
      default:
        return gender;
    }
  }

  String get translatedOrigin {
    String translated = origin;

    if (translated.toLowerCase().contains('earth')) {
      translated = translated.replaceAll(
        RegExp('earth', caseSensitive: false),
        'Terra',
      );
    }
    if (translated.toLowerCase().contains('unknown')) {
      translated = translated.replaceAll(
        RegExp('unknown', caseSensitive: false),
        'Desconhecido',
      );
    }
    if (translated.toLowerCase().contains('Dimension')) {
      translated = translated.replaceAll(
        RegExp('Dimension', caseSensitive: false),
        'Dimensão',
      );
    }
    if (translated.toLowerCase().contains('citadel')) {
      translated = translated.replaceAll(
        RegExp('Citadel', caseSensitive: false),
        'Cidadela',
      );
    }

    return translated;
  }
}
