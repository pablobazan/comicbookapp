import 'package:comicbookapp/core/localization/strings.dart';
import 'package:comicbookapp/home/domain/entities/issue.dart';
import 'package:comicbookapp/home/presentation/widgets/home/comic_list_element.dart';
import 'package:comicbookapp/home/presentation/widgets/loading_fade_in_up/loading_fade_in_up.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ComicListContent extends StatelessWidget {
  const ComicListContent({
    super.key,
    required ScrollController scrollController,
    required this.issues,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Issue> issues;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: issues.length,
            itemBuilder: (context, index) {
              final name = issues[index].name ?? Strings.noName;
              final issueNumber = issues[index].issueNumber ?? Strings.noDate;
              return ComicListElement(
                  issues: issues[index], name: name, issueNumber: issueNumber);
            },
          ),
        ),
        const LoadingFadeInUp(),
      ],
    );
  }
}
