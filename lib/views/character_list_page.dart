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
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadCharacters.execute();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _searchController = TextEditingController();
    _searchController.addListener(_searchListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _scrollController.removeListener(_scrollListener);

    _searchController.removeListener(_searchListener);
    _searchController.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      widget.viewModel.loadNextPageCharacters.execute();
    }
  }

  void _searchListener() {
    final query = _searchController.text;
    if (query.isEmpty &&
        !widget.viewModel.loadCharacters.running &&
        !widget.viewModel.searchCharacters.running) {
      widget.viewModel.loadCharacters.execute();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Buscar personagem...',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(fontSize: 18.0),
          onSubmitted: (value) {
            if (value.isNotEmpty &&
                !widget.viewModel.searchCharacters.running) {
              widget.viewModel.searchCharacters.execute(value);
            }
          },
        ),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.viewModel.loadCharacters,
          builder: (context, child) {
            final isRunnig =
                widget.viewModel.loadCharacters.running ||
                widget.viewModel.searchCharacters.running;

            final hasFailure =
                widget.viewModel.loadCharacters.failure ||
                widget.viewModel.searchCharacters.failure;

            final errorMessage =
                widget.viewModel.loadCharacters.errorMessage ??
                widget.viewModel.searchCharacters.errorMessage;

            if (isRunnig) {
              return Center(child: CircularProgressIndicator());
            } else if (hasFailure) {
              return Center(child: Text(errorMessage ?? 'Error'));
            }
            return child!;
          },
          child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: LayoutBuilder(
                  builder: (context, constrains) {
                    final crossAxisCount = constrains.maxWidth < 600
                        ? 2
                        : constrains.maxWidth < 900
                        ? 3
                        : 4;

                    final childAspectRatio = constrains.maxWidth < 600
                        ? 0.8
                        : 0.9;

                    return CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverGrid.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: childAspectRatio,
                              ),
                          itemCount: widget.viewModel.characters.length,
                          itemBuilder: (context, index) {
                            final character =
                                widget.viewModel.characters[index];
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
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
