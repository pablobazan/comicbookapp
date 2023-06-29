import 'package:comicbookapp/core/localization/strings.dart';
import 'package:comicbookapp/core/styles/colors.dart';
import 'package:comicbookapp/core/styles/styles.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, required this.retryConnection}) : super(key: key);

  final VoidCallback retryConnection;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          Icon(
            Icons.error_outline_rounded,
            size: 30.w,
          ),
          SizedBox(
            height: 4.h,
          ),
          SizedBox(
            height: 0.5.h,
          ),
          Text(
            Strings.noInternet,
            style: Styles.noInternetConnectionTextStyle(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h),
            child: OutlinedButton(
                onPressed: () => retryConnection(),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.gray),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                ),
                child: Text(
                  Strings.retryConnection,
                  style: Styles.buttonRetryConenctionTextStyle(),
                )),
          ),
        ],
      ),
    );
  }
}
