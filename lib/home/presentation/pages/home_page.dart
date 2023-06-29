import 'package:comicbookapp/core/localization/strings.dart';
import 'package:comicbookapp/core/presentation/pages/error_page_widget.dart';
import 'package:comicbookapp/core/presentation/pages/loading_page.dart';
import 'package:comicbookapp/core/styles/colors.dart';
import 'package:comicbookapp/core/styles/styles.dart';
import 'package:comicbookapp/home/presentation/blocs/bloc/home/home_bloc.dart';
import 'package:comicbookapp/home/presentation/widgets/home/comic_list_content.dart';
import 'package:comicbookapp/home/presentation/widgets/home/comic_grid_content.dart';
import 'package:comicbookapp/home/presentation/widgets/loading_fade_in_up/bloc/loading_fade_in_up_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  int page = 1;

  @override
  void initState() {
    _scrollController = ScrollController();
    BlocProvider.of<HomeBloc>(context).add(GetIssuesEvent(page: page));

    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<LoadingFadeInUpBloc>(context)
            .add(LoadingFadeInUpShowItEvent());
        context.read<HomeBloc>().add(GetIssuesEvent(page: ++page));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loadingBloc = BlocProvider.of<LoadingFadeInUpBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gray,
        centerTitle: false,
        titleSpacing: 6.w,
        title: Text(Strings.comicBook, style: Styles.titleHomeAppBarStyle()),
        actions: [
          IconButton(
            onPressed: () {
              homeBloc
                  .add(const SwitchViewTypeEvent(viewType: HomeViewType.list));
            },
            icon: const Icon(Icons.list_alt_outlined, color: AppColors.black),
          ),
          IconButton(
            onPressed: () {
              homeBloc
                  .add(const SwitchViewTypeEvent(viewType: HomeViewType.grid));
            },
            icon: const Icon(Icons.grid_view_outlined, color: AppColors.black),
          ),
        ],
      ),
      backgroundColor: AppColors.gray400,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoadedState) {
            loadingBloc.add(LoadingFadeInUpHideItEvent());
          }
        },
        builder: (context, state) {
          if (state is HomeErrorState) {
            return ErrorPage(
              retryConnection: () {
                context.read<HomeBloc>().add(GetIssuesEvent(page: page));
              },
            );
          } else if (state is HomeLoadingState) {
            return const LoadingPage();
          } else if (state is HomeLoadedState) {
            return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: switch (state.viewType) {
                  HomeViewType.grid => ComicGridContent(
                      scrollController: _scrollController,
                      issues: state.issues!.results,
                    ),
                  HomeViewType.list => ComicListContent(
                      scrollController: _scrollController,
                      issues: state.issues!.results,
                    ),
                });
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

enum HomeViewType { grid, list }
