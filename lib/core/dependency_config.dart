import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/data/repositories/character_repository.dart';
import 'package:rick_and_morty_app/data/services/api_services.dart';
import 'package:rick_and_morty_app/viewmodels/character_list_viewmodel.dart';

List<SingleChildWidget> get appProviders => [
  // --- Nível 1: Ferramentas (Dio) ---
  Provider<Dio>(
    create: (context) {
      final options = BaseOptions(
        baseUrl: 'https://rickandmortyapi.com/api',
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 3),
      );
      return Dio(options);
    },
  ),

  // --- Nível 2: Serviços (ApiService) ---
  Provider<IApiService>(
    create: (context) {
      final dio = context.read<Dio>();

      return ApiServiceImpl(dio);
    },
  ),

  // --- Nível 3: Repositórios (Repository) ---
  Provider<ICharacterRepository>(
    create: (context) {
      final apiService = context.read<IApiService>();

      return CharacterRepositoryImpl(apiService);
    },
  ),

  // --- Nível 4: ViewModels ---
  ChangeNotifierProvider<CharacterListViewmodel>(
    create: (context) {
      final characterRepository = context.read<ICharacterRepository>();

      return CharacterListViewmodel(characterRepository: characterRepository);
    },
  ),
];
