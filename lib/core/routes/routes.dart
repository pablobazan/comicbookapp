import 'package:comicbookapp/home/presentation/pages/comic_details_page.dart';
import 'package:comicbookapp/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const homePage = '/home';
  static const comicDetailsPage = '/comicDetails';
}

class Pages {
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.homePage: (_) => const HomePage(),
    Routes.comicDetailsPage: (_) => const ComicDetailsPage(),
  };
}
