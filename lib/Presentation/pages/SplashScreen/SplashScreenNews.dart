import 'package:flutter/material.dart';
import 'package:news/Presentation/pages/Home/HomePage.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool orientation = MediaQuery
        .of(context)
        .orientation == Orientation.portrait;

    ThemeData _currentTheme = Theme.of(context);
    return SplashScreen(
      photoSize:
      orientation ? (MediaQuery
          .of(context)
          .size
          .height / 5.5) : MediaQuery
          .of(context)
          .size
          .height / 3.5,
      seconds: 7,
      useLoader: orientation,
      navigateAfterSeconds: HomePage(),
      title: Text(
        'Breaking News',
        style: TextStyle(
            fontFamily: 'ViaodaLibre',
            fontWeight: FontWeight.bold,
            fontSize: orientation? 20.0:15.0),
      ),
      image: Image.asset('assets/images/logo.png'),
      backgroundColor: _currentTheme.backgroundColor,
      loaderColor: _currentTheme.accentColor,
    );
  }
}
