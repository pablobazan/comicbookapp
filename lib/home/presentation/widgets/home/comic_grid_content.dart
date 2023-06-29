import 'package:comicbookapp/home/domain/entities/issue.dart';
import 'package:comicbookapp/home/presentation/widgets/home/comic_gird_element.dart';
import 'package:comicbookapp/home/presentation/widgets/loading_fade_in_up/loading_fade_in_up.dart';
import 'package:flutter/material.dart';

class ComicGridContent extends StatelessWidget {
  const ComicGridContent(
      {super.key,
      required ScrollController scrollController,
      required this.issues})
      : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Issue> issues;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 0.70,
          ),
          controller: _scrollController,
          itemCount: issues.length,
          itemBuilder: (context, index) {
            return ComicGridElement(issues: issues[index]);
          },
        ),
        const LoadingFadeInUp(),
      ],
    );
  }
}
