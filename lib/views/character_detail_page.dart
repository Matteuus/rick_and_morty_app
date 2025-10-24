import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/model/character_model.dart';

class CharacterDetailPage extends StatelessWidget {
  const CharacterDetailPage({super.key, required this.character});

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final isDesktop = constraints.maxWidth >= 600;

                return isDesktop
                    ? _buildDesktopLayout(character)
                    : _buildMobileLayout(character);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(CharacterModel character) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(character.image, height: 300, fit: BoxFit.contain),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildDetailsColumn(character, TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(CharacterModel character) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(character.image, height: 300, width: 300),
          const SizedBox(width: 24),
          Expanded(
            child: _buildDetailsColumn(character, TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }

  // Método para construir as linhas de texto de detalhes
  Widget _buildDetailsColumn(CharacterModel character, TextStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Status: ${character.translatedStatus}', style: style),
        Text('Espécie: ${character.translatedSpecies}', style: style),
        Text('Gênero: ${character.translatedGender}', style: style),
        Text('Origem: ${character.translatedOrigin}', style: style),
        // ... Adicione quaisquer outros detalhes importantes aqui ...
      ],
    );
  }
}
