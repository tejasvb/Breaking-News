import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news/Widgets/NewsCard.dart';
import 'package:news/Widgets/secondaryNewsWidget.dart';
import 'package:news/models/NewsForListing.dart';
import 'package:news/models/api_response.dart';
import 'package:news/service/news_service.dart';

class Content extends StatefulWidget {
  final String url;
  final String name;
  final String sub;
  final String category;

  Content({this.url, this.name, this.sub, this.category});

  @override
  _ContentState createState() => _ContentState();
}

int _current = 0;

class _ContentState extends State<Content> {
  NewsService get service => GetIt.I<NewsService>();

  APIResponse<List<NewsForListing>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchNews();
    super.initState();
  }

  _fetchNews() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse =
        await service.getNewsList(category: widget.category, field: widget.sub);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Builder(
        builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_apiResponse.error) {
            return Text(_apiResponse.errorMessage);
          }

          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 3, color: Colors.grey),
            itemBuilder: (BuildContext context, int index) {
              if (index < 1) {
                return Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: _apiResponse.data.length,
                      itemBuilder:
                          (BuildContext context, int index1, int realIndex) {
                        return Material(
                          child: NewsCard(
                              source:
                                  _apiResponse.data[index1].source.toString(),
                              author:
                                  _apiResponse.data[index1].author.toString(),
                              image: _apiResponse.data[index1].urlToImage !=
                                      null
                                  ? _apiResponse.data[index1].urlToImage
                                      .toString()
                                  : "https://www.nmaer.com/sysimg/news-news-image.png",
                              title: _apiResponse.data[index1].title.toString(),
                              publishedAt: _apiResponse.data[index1].publishedAt
                                  .toString(),
                              content:
                                  _apiResponse.data[index1].content.toString(),
                              url: _apiResponse.data[index1].url.toString()),
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
                      children: _apiResponse.data.map((url) {
                        int index = _apiResponse.data.indexOf(url);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? Color.fromRGBO(0, 0, 0, 0.9)
                                : Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              } else {
                return SecondaryNewsWidget(
                    source: _apiResponse.data[index].source.toString(),
                    author: _apiResponse.data[index].author.toString(),
                    image: _apiResponse.data[index].urlToImage != null
                        ? _apiResponse.data[index].urlToImage.toString()
                        : "",
                    title: _apiResponse.data[index].title.toString(),
                    publishedAt:
                        _apiResponse.data[index].publishedAt.toString(),
                    content: _apiResponse.data[index].content.toString(),
                    url: _apiResponse.data[index].url.toString());
              }
            },
            itemCount: _apiResponse.data.length,
          );
        },
      ),
    );
  }
}
