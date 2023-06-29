import 'package:comicbookapp/core/localization/strings.dart';
import 'package:comicbookapp/core/platform/injector_factory.dart';
import 'package:comicbookapp/core/presentation/pages/loading_page.dart';
import 'package:comicbookapp/core/styles/colors.dart';
import 'package:comicbookapp/core/styles/styles.dart';
import 'package:comicbookapp/home/domain/entities/issue.dart';
import 'package:comicbookapp/home/domain/use_cases/get_characters.dart';
import 'package:comicbookapp/home/presentation/blocs/bloc/comic_details/comic_details_bloc.dart';
import 'package:comicbookapp/home/presentation/widgets/comics_details/bloc/bloc/list_characters_bloc.dart';
import 'package:comicbookapp/home/presentation/widgets/comics_details/list_characters.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ComicDetailsPage extends StatelessWidget {
  const ComicDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final issue = ModalRoute.of(context)!.settings.arguments as Issue;
    BlocProvider.of<ComicDetailsBloc>(context)
        .add(GetCharacterDetailsEvent(apiDetailUrl: issue.apiDetailUrl));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gray,
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: false,
        titleSpacing: 6.w,
        title: Text(Strings.comicDetails, style: Styles.titleHomeAppBarStyle()),
      ),
      backgroundColor: AppColors.gray400,
      body: BlocBuilder<ComicDetailsBloc, ComicDetailsState>(
        builder: (context, state) {
          if (state is CharacterDetailsLoading) {
            return const LoadingPage();
          } else if (state is CharacterDetailsLoaded) {
            return _ComicDetailsContent(
              imageUrl: state.issue.image!.originalUrl!,
              charactersUrl: state.issue.characterCredits!
                  .map((e) => e.apiDetailUrl)
                  .toList(),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ComicDetailsContent extends StatelessWidget {
  _ComicDetailsContent({required this.imageUrl, required this.charactersUrl});

  final String imageUrl;
  final List<String> charactersUrl;

  final blocCharacters = ListCharactersBloc(
    getCharactersUseCase: GetCharactersUseCase(
      repository: InjectorFactory.createCharacterRepository(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.only(top: 3.h, left: 3.w, right: 3.w),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  flex: 40,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Column(
                      children: [
                        const Text(Strings.characters),
                        Divider(
                          color: AppColors.black,
                          thickness: 0.03.h,
                        ),
                        BlocProvider<ListCharactersBloc>.value(
                          value: blocCharacters,
                          child: ListCharacters(
                            urlList: charactersUrl,
                            scrollDirection: Axis.vertical,
                            height: 38.h,
                          ),
                        ),
                      ],
                    ),
                  )),
              Flexible(
                flex: 60,
                child: Hero(
                  tag: imageUrl,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.error),
                      );
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
