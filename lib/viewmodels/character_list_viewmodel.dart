import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty_app/core/utils/command.dart';
import 'package:rick_and_morty_app/core/utils/result.dart';
import 'package:rick_and_morty_app/data/repositories/character_repository.dart';
import 'package:rick_and_morty_app/model/character_model.dart';

class CharacterListViewmodel extends ChangeNotifier {
  CharacterListViewmodel({required ICharacterRepository characterRepository})
    : _characterRepository = characterRepository {
    loadCharacters = Command0(_loadCharacters)..execute();
    loadNextPageCharacters = Command0(_loadNextPageCharacters);
    searchCharacters = Command1<List<CharacterModel>, String>(
      _searchCharacters,
    );
  }

  final ICharacterRepository _characterRepository;

  String? _nextPageUrl;
  String? get nextPageUrl => _nextPageUrl;

  int _totalPages = 1;
  int get totalPages => _totalPages;

  bool _isPaginating = false;
  bool get isPaginating => _isPaginating;

  List<CharacterModel> _characters = [];
  List<CharacterModel> get characters => _characters;

  late Command0 loadCharacters;
  late Command0 loadNextPageCharacters;
  late Command1<List<CharacterModel>, String> searchCharacters;

  Future<Result> _loadCharacters() async {
    try {
      final result = await _characterRepository.fetchAllCharacters();
      switch (result) {
        case Success(:final data):
          _characters = data.results;
          _nextPageUrl = data.next;
          _totalPages = data.pages;
          return Success(_characters);
        case Failure(:final error):
          return Failure(error);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _loadNextPageCharacters() async {
    if (_nextPageUrl == null || _isPaginating) {
      return Failure('No more pages to load or already paginating.');
    }

    try {
      _isPaginating = true;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 1000));
      final result = await _characterRepository.fetchAllCharacters(
        url: _nextPageUrl,
      );
      switch (result) {
        case Success(:final data):
          _characters.addAll(data.results);
          _nextPageUrl = data.next;
          return Success(_characters);
        case Failure(:final error):
          return Failure(error);
      }
    } finally {
      _isPaginating = false;
      notifyListeners();
    }
  }

  Future<Result<List<CharacterModel>>> _searchCharacters(String name) async {
    try {
      _nextPageUrl = null;
      _totalPages = 1;
      await Future.delayed(Duration(milliseconds: 1000));
      final result = await _characterRepository.fetchAllCharacters(name: name);

      switch (result) {
        case Success(:final data):
          _characters = data.results;
          _nextPageUrl = data.next;
          _totalPages = data.pages;
          notifyListeners();
          return Success(_characters);
        case Failure(:final error):
          _characters = [];
          notifyListeners();
          return Failure(error);
      }
    } finally {
      notifyListeners();
    }
  }
}
