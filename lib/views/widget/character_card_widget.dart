import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/model/character_model.dart';

class CharacterCardWidget extends StatelessWidget {
  const CharacterCardWidget({super.key, required this.character});

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(character.image),
          SizedBox(height: 16),
          Text(character.name, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
