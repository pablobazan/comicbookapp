import 'package:comicbookapp/core/localization/strings.dart';
import 'package:comicbookapp/core/presentation/pages/loading_page.dart';
import 'package:comicbookapp/core/styles/styles.dart';
import 'package:comicbookapp/home/domain/entities/character.dart';
import 'package:comicbookapp/home/presentation/widgets/comics_details/bloc/bloc/list_characters_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ListCharacters extends StatelessWidget {
  const ListCharacters(
      {super.key,
      required this.urlList,
      required this.scrollDirection,
      required this.height});

  final List<String> urlList;
  final Axis scrollDirection;
  final double height;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ListCharactersBloc>(context)
        .add(ListCharactersInitialEvent(urlList: urlList));
    return SizedBox(
      height: height,
      child: BlocBuilder<ListCharactersBloc, ListCharactersState>(
        builder: (context, state) {
          if (state is ListCharactersLoading) {
            return const LoadingPage();
          } else if (state is ListCharactersEmpty) {
            return const Center(
              child: Text(Strings.noCharacters),
            );
          } else if (state is ListCharactersError) {
            return const Center(
              child: Text(Strings.error),
            );
          } else if (state is ListCharactersLoaded) {
            return _Content(
              characters: state.characters,
              scrollDirection: scrollDirection,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.characters,
    required this.scrollDirection,
  });

  final List<Character> characters;
  final Axis scrollDirection;
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        scrollDirection: scrollDirection,
        shrinkWrap: true,
        itemCount: characters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Flexible(
                    flex: 30,
                    child: Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Image.network(
                        characters[index].image!.iconUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.error),
                          );
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 70,
                    child: Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Text(
                        characters[index].name ?? Strings.noName,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.aliasCharactersTextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
