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
}
