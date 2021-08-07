import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news/Presentation/Widgets/NewsCard.dart';
import 'package:news/models/NewsForListing.dart';
import 'package:news/models/api_response.dart';

class CarouselSliderForNews extends StatefulWidget {
  final APIResponse<List<NewsForListing>> apiResponse;
  final BuildContext themeContext;

  const CarouselSliderForNews({@required this.apiResponse,@required  this.themeContext});

  @override
  State<CarouselSliderForNews> createState() => _CarouselSliderForNewsState();
}

class _CarouselSliderForNewsState extends State<CarouselSliderForNews> {
  ThemeData currentTheme;
  int _current = 0;
  @override
  Widget build(BuildContext currentContext) {
    currentTheme = Theme.of(widget.themeContext);
    return Container(
      child: Column(
          children: [
        CarouselSlider.builder(
          itemCount: widget.apiResponse.data.length,
          itemBuilder: (BuildContext context, int index1, int realIndex) {
            return Material(
              color:currentTheme.primaryColor,
              child: NewsCard(
                  source: widget.apiResponse.data[index1].source.toString(),
                  author: widget.apiResponse.data[index1].author.toString(),
                  image: widget.apiResponse.data[index1].urlToImage != null
                      ? widget.apiResponse.data[index1].urlToImage.toString()
                      : "https://www.nmaer.com/sysimg/news-news-image.png",
                  title: widget.apiResponse.data[index1].title.toString(),
                  publishedAt:
                      widget.apiResponse.data[index1].publishedAt.toString(),
                  url: widget.apiResponse.data[index1].url.toString(),
                themeContext: widget.themeContext,
              ),
            );
          },
          options: CarouselOptions(
              autoPlay: true,
              height: 340,
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
          children: widget.apiResponse.data.map((url) {
            int index = widget.apiResponse.data.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? currentTheme.accentColor
                    : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
