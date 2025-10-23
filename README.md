# rick_and_morty_app

Um projeto Flutter para exibir personagens da série Rick and Morty usando a API pública.

## Visão geral
Aplicativo Flutter que lista personagens, permite paginação e exibe detalhes de cada personagem.

Principais telas e classes:
- Tela principal: [`CharacterListPage`](lib/views/character_list_page.dart)
- Tela de detalhes: [`CharacterDetailPage`](lib/views/character_detail_page.dart)
- ViewModel da lista: [`CharacterListViewmodel`](lib/viewmodels/character_list_viewmodel.dart)

Repositório e serviço de API:
- Interface e implementação do repositório: [`ICharacterRepository`](lib/data/repositories/character_repository.dart) / [`CharacterRepositoryImpl`](lib/data/repositories/character_repository.dart)
- Serviço HTTP: [`IApiService`](lib/data/services/api_services.dart) / [`ApiServiceImpl`](lib/data/services/api_services.dart)

Modelos:
- [`CharacterModel`](lib/model/character_model.dart)
- [`CharacterResponse`](lib/model/character_response.dart)

Utilitários:
- Comandos reativos: [`Command`](lib/core/utils/command.dart) / [`Command0`](lib/core/utils/command.dart)
- Resultado operacional: [`Result`](lib/core/utils/result.dart), [`Success`](lib/core/utils/result.dart), [`Failure`](lib/core/utils/result.dart)

## Estrutura relevante
- [lib/main.dart](lib/main.dart) — ponto de entrada (`[`MyApp`](lib/main.dart)`).
- [lib/core/dependency_config.dart](lib/core/dependency_config.dart) — configuração de providers (injeção de dependências).
- [lib/views/character_list_page.dart](lib/views/character_list_page.dart) — lista + paginação.
- [lib/views/character_detail_page.dart](lib/views/character_detail_page.dart) — detalhes do personagem.
- [lib/viewmodels/character_list_viewmodel.dart](lib/viewmodels/character_list_viewmodel.dart) — lógica de UI e paginação.
- [lib/data/repositories/character_repository.dart](lib/data/repositories/character_repository.dart) — camada de repositório.
- [lib/data/services/api_services.dart](lib/data/services/api_services.dart) — chamada à API (Dio).
- [lib/model/character_model.dart](lib/model/character_model.dart) e [lib/model/character_response.dart](lib/model/character_response.dart) — modelos.
- [pubspec.yaml](pubspec.yaml) — dependências (Dio, provider, go_router, ...).
- [.fvmrc](.fvmrc) — versão Flutter usada no projeto.
- [test/widget_test.dart](test/widget_test.dart) — teste exemplo.

## Requisitos
- Flutter (usar versão indicada em [.fvmrc](.fvmrc) se estiver usando FVM).
- Android/iOS/Mac/Linux toolchains conforme plataforma alvo.
- Dependências definidas em [pubspec.yaml](pubspec.yaml).

## Como rodar (development)
1. Instale dependências:
   ```sh
   flutter pub get
