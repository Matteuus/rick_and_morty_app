import 'package:rick_and_morty_app/core/utils/result.dart';
import 'package:rick_and_morty_app/data/services/api_services.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:rick_and_morty_app/model/character_response.dart';

abstract class ICharacterRepository {
  Future<Result<CharacterResponse>> fetchAllCharacters({String? url});
  Future<Result<CharacterModel>> fetchCharacterById(int id);
}

class CharacterRepositoryImpl implements ICharacterRepository {
  final IApiService _apiService;

  CharacterRepositoryImpl(this._apiService);

  @override
  Future<Result<CharacterResponse>> fetchAllCharacters({String? url}) async {
    try {
      final response = await _apiService.getAllCharacters(url: url);
      final charactersResponse = CharacterResponse.fromJson(response);
      return Success(charactersResponse);
    } catch (e) {
      return Failure('Falha ao recuperar personagens: $e');
    }
  }

  @override
  Future<Result<CharacterModel>> fetchCharacterById(int id) async {
    try {
      final response = await _apiService.getCharacterById(id);
      final character = CharacterModel.fromJson(response);
      return Success(character);
    } catch (e) {
      return Failure('Failed ao retornar personagem: $e');
    }
  }
}
