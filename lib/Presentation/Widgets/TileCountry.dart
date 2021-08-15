import 'package:flutter/material.dart';
import '../bottomNavigationPages/specificCountryNews/SpecificCountryNews.dart';

class TileCountry extends StatelessWidget {
  final String url;
  final String name;
  final String sub;
  final BuildContext themeContext;

  const TileCountry({@required this.url,@required  this.name,@required  this.sub,@required  this.themeContext});

  @override
  Widget build(BuildContext context) {
    ThemeData _currentTheme = Theme.of(themeContext);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpecificCountryNews(
              url: url,
              name: name,
              sub: sub,
              themeContext: themeContext,
            ),
          ),
        );
      },
      child: Hero(
        tag: name,
        child: Container(
          color: _currentTheme.primaryColor,
          child: Column(
            children: [
              SizedBox(
                height: 90,
                width: 90,
                child: Image.network(url),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 15,
                  color: _currentTheme.accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
