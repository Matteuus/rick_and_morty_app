import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/viewmodels/character_list_viewmodel.dart';
import 'package:rick_and_morty_app/views/widget/character_card_widget.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key, required this.viewModel});

  final CharacterListViewmodel viewModel;

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadCharacters.execute();
    _scrollController = ScrollController();

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _scrollController.removeListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      widget.viewModel.loadNextPageCharacters.execute();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty App')),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.viewModel.loadCharacters,
          builder: (context, child) {
            if (widget.viewModel.loadCharacters.running) {
              return Center(child: CircularProgressIndicator());
            } else if (widget.viewModel.loadCharacters.failure) {
              return Center(
                child: Text(
                  widget.viewModel.loadCharacters.errorMessage ?? 'Error',
                ),
              );
            }
            return child!;
          },
          child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: widget.viewModel.characters.length,
                      itemBuilder: (context, index) {
                        final character = widget.viewModel.characters[index];
                        return InkWell(
                          onTap: () {
                            context.push(
                              '/character/${character.id}',
                              extra: character,
                            );
                          },
                          child: CharacterCardWidget(character: character),
                        );
                      },
                    ),
                    if (widget.viewModel.isPaginating)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
