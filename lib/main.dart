import 'package:comicbookapp/core/platform/injector_factory.dart';
import 'package:comicbookapp/core/platform/main_servicies.dart';
import 'package:comicbookapp/home/domain/repositories/character_repository.dart';
import 'package:comicbookapp/home/domain/repositories/issue_repository.dart';
import 'package:comicbookapp/home/domain/use_cases/get_characters.dart';
import 'package:comicbookapp/home/domain/use_cases/get_issue_detail.dart';
import 'package:comicbookapp/home/domain/use_cases/get_issues.dart';
import 'package:comicbookapp/home/presentation/blocs/bloc/comic_details/comic_details_bloc.dart';

import 'package:comicbookapp/home/presentation/blocs/bloc/home/home_bloc.dart';
import 'package:comicbookapp/home/presentation/widgets/loading_fade_in_up/bloc/loading_fade_in_up_bloc.dart';
import 'package:comicbookapp/material_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainServices().init();

  runApp(const ComicBookApp());
}

class ComicBookApp extends StatelessWidget {
  const ComicBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final IssueRepository issueRepository =
        InjectorFactory.createIssueRepository();
    final CharacterRepository characterRepository =
        InjectorFactory.createCharacterRepository();

    return MultiBlocProvider(providers: [
      BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(
          getIssuesUseCase: GetIssuesUseCase(repository: issueRepository),
        ),
      ),
      BlocProvider(create: (context) => LoadingFadeInUpBloc()),
      BlocProvider(
          create: (context) => ComicDetailsBloc(
                getIssueDetail:
                    GetIssueDetailUseCase(repository: issueRepository),
                getCharacters:
                    GetCharactersUseCase(repository: characterRepository),
              ))
    ], child: const AppView());
  }
}
