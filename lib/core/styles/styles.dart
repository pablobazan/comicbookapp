import 'package:comicbookapp/core/styles/colors.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class Styles {
  static TextStyle titleHomeAppBarStyle() {
    return TextStyle(
      fontSize: 16.sp,
      color: AppColors.black,
    );
  }

  static TextStyle noInternetConnectionTextStyle() {
    return TextStyle(
      fontSize: 16.sp,
      color: AppColors.black,
    );
  }

  static TextStyle buttonRetryConenctionTextStyle() {
    return TextStyle(
      fontSize: 12.sp,
      color: AppColors.black,
    );
  }

  static TextStyle aliasCharactersTextStyle() {
    return TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    );
  }
}
