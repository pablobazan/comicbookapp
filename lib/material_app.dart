import 'package:comicbookapp/core/localization/strings.dart';
import 'package:comicbookapp/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.comicBookApp,
          routes: Pages.routes,
          initialRoute: Routes.homePage,
        );
      },
    );
  }
}
