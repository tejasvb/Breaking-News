import 'package:flutter/material.dart';

import 'package:news/Presentation/pages/Home/HomePage.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      photoSize:200.0,
      seconds: 7,
      navigateAfterSeconds:HomePage(),
      title:  Text(
        'Breaking News',
        style:  TextStyle(fontFamily: 'ViaodaLibre',fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image:  Image.asset('assets/images/logo.png'),
      backgroundColor: Theme.of(context).backgroundColor,
      loaderColor: Theme.of(context).accentColor,
    );
  }
}
