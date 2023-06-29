import 'package:comicbookapp/core/routes/routes.dart';
import 'package:comicbookapp/core/styles/colors.dart';
import 'package:comicbookapp/core/styles/styles.dart';
import 'package:comicbookapp/core/utils/date_utils.dart';
import 'package:comicbookapp/home/domain/entities/issue.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ComicListElement extends StatelessWidget {
  const ComicListElement({
    super.key,
    required this.issues,
    required this.name,
    required this.issueNumber,
  });

  final Issue issues;
  final String name;
  final String issueNumber;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.comicDetailsPage,
            arguments: issues);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        height: 28.h,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36.w,
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 0.5.w,
                    color: AppColors.black,
                  )),
                  child: Image.network(
                    issues.image!.originalUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 23.h,
                        width: 36.w,
                        color: AppColors.gray,
                        child: const Center(
                          child: Icon(Icons.error),
                        ),
                      );
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 23.h,
                        width: 36.w,
                        color: AppColors.white,
                        child: const Center(
                          child: SizedBox(child: CircularProgressIndicator()),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 50.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "$name $issueNumber",
                        style: Styles.aliasCharactersTextStyle(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        DateUtilsApp.formatDateMonthDayYear(issues.dateAdded),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Divider(
              color: AppColors.black,
              thickness: 0.03.h,
            ),
          ],
        ),
      ),
    );
  }
}
