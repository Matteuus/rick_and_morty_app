import 'package:rick_and_morty_app/model/character_model.dart';

sealed class CharacterListState {}

final class EmptyState extends CharacterListState {}

final class LoadingState extends CharacterListState {}

final class SuccessState extends CharacterListState {
  final List<CharacterModel> characters;

  SuccessState(this.characters);
}

final class ErrorState extends CharacterListState {
  final String message;

  ErrorState(this.message);
}
