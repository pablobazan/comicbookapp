import 'package:comicbookapp/core/localization/strings.dart';
import 'package:comicbookapp/core/routes/routes.dart';
import 'package:comicbookapp/core/styles/colors.dart';
import 'package:comicbookapp/core/styles/styles.dart';
import 'package:comicbookapp/core/utils/date_utils.dart';
import 'package:comicbookapp/home/domain/entities/issue.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ComicGridElement extends StatelessWidget {
  const ComicGridElement({
    super.key,
    required this.issues,
  });

  final Issue issues;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 1.h),
      width: 42.w,
      height: 30.h,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.comicDetailsPage,
                  arguments: issues);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                width: 0.5.w,
                color: AppColors.black,
              )),
              child: Hero(
                tag: issues.image!.originalUrl!,
                child: Image.network(
                  height: 25.h,
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
                      color: AppColors.gray,
                      child: const Center(
                        child: SizedBox(child: CircularProgressIndicator()),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            issues.name ?? Strings.noName,
            style: Styles.aliasCharactersTextStyle(),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 0.5.h),
          Text(
            DateUtilsApp.formatDateMonthDayYear(issues.dateAdded),
          ),
        ],
      ),
    );
  }
}
