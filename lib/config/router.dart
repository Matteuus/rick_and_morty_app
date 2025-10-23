import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:rick_and_morty_app/viewmodels/character_list_viewmodel.dart';
import 'package:rick_and_morty_app/views/character_detail_page.dart';
import 'package:rick_and_morty_app/views/character_list_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final viewModel = context.read<CharacterListViewmodel>();

        return CharacterListPage(viewModel: viewModel);
      },
    ),
    GoRoute(
      path: '/character/:id',
      builder: (context, state) {
        final character = state.extra;
        // You can create and return CharacterDetailPage here using the character data
        // 2. Converte e checa: Se for um CharacterModel, retorna a tela
        if (character is CharacterModel) {
          // 3. O ViewModel para a tela de detalhes é simples: ele só recebe o Model!
          return CharacterDetailPage(character: character);
        }

        // 4. Caso o objeto extra não exista ou não seja o tipo certo (por exemplo,
        // se o usuário tentar digitar a URL direto), voltamos para a lista.
        return CharacterListPage(
          viewModel: context.read<CharacterListViewmodel>(),
        );
      },
    ),
  ],
);
