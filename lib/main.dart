import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:news/SplashScreen/SplashScreenNews.dart';
import 'package:news/service/news_service.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => NewsService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreenNews(),
    );
  }
}
