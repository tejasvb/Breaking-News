import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news/service/news_service.dart';
import 'package:news/theme/app_theme.dart';
import 'package:news/Presentation/pages/SplashScreen/SplashScreenNews.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => NewsService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: SplashScreenNews(),
    );
  }
}
