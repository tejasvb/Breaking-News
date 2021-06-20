import 'package:flutter/material.dart';
import 'package:news/NewsByCountry/SpecificCountryNews.dart';


class TileCountry extends StatelessWidget {
  final String url;
  final String name;
  final String sub;

  TileCountry({this.url, this.name, this.sub});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SpecificCountryNews(
                  url: url, name: name, sub: sub)),
        );
      },
      child: Column(
        children: [
          SizedBox(height: 90, width: 90, child: Image.network(url)),
          Text(
            name,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
