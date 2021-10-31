import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news/Presentation/Widgets/NewsCard.dart';
import 'package:news/models/NewsForListing.dart';

class CarouselSliderForNews extends StatefulWidget {
  final List<NewsForListing> newsList;
  final BuildContext themeContext;

  const CarouselSliderForNews(
      {@required this.newsList, @required this.themeContext});

  @override
  State<CarouselSliderForNews> createState() => _CarouselSliderForNewsState();
}

class _CarouselSliderForNewsState extends State<CarouselSliderForNews> {
  ThemeData _currentTheme;
  int _current = 0;

  @override
  Widget build(BuildContext currentContext) {
    _currentTheme = Theme.of(widget.themeContext);
    return Container(
      child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: widget.newsList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Material(
                  color: _currentTheme.primaryColor,
                  child: NewsCard(
                    source: widget.newsList[index].source.toString(),
                    author: widget.newsList[index].author.toString(),
                    image: (widget.newsList[index].urlToImage == null &&
                        widget.newsList[index].urlToImage.toString().contains('file:'))
                        ?"https://www.nmaer.com/sysimg/news-news-image.png"
                        : widget.newsList[index].urlToImage.toString(),
                    title: widget.newsList[index].title.toString(),
                    publishedAt:
                    widget.newsList[index].publishedAt.toString(),
                    url: widget.newsList[index].url.toString(),
                    themeContext: widget.themeContext,
                  ),
                );
              },
              options: CarouselOptions(
                  autoPlay: true,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2.1,
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.newsList.map((url) {
                int index = widget.newsList.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? _currentTheme.accentColor
                        : Colors.grey,
                  ),
                );
              }).toList(),
            ),
          ]),
    );
  }
}
