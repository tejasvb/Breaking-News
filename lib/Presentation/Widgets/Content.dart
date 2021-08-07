import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news/Presentation/Widgets/CarouselSliderForNews.dart';
import 'package:news/Presentation/Widgets/SecondaryNewsCard.dart';

import 'package:news/models/NewsForListing.dart';
import 'package:news/models/api_response.dart';
import 'package:news/service/news_service.dart';

class Content extends StatefulWidget {
  final String url;
  final String name;
  final String sub;
  final String category;
  final BuildContext themeContext;

  Content(
      {@required this.url,
      @required this.name,
      @required this.sub,
      @required this.category,
      @required this.themeContext});

  @override
  _ContentState createState() => _ContentState();
}

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
  Widget build(BuildContext currentContext) {
    ThemeData currentTheme = Theme.of(widget.themeContext);
    return Container(
      color: currentTheme.primaryColor,
      child: Builder(
        builder: (_) {
          if (_isLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: currentTheme.accentColor,
            ));
          }

          if (_apiResponse.error) {
            return Text(_apiResponse.errorMessage);
          }
          return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 3, color: Colors.grey),
            itemBuilder: (BuildContext context, int index) {
              if (index < 1) {
                return CarouselSliderForNews(
                    apiResponse: _apiResponse,
                    themeContext: widget.themeContext);
              }
              return SecondaryNewsCard(
                source: _apiResponse.data[index].source.toString(),
                author: _apiResponse.data[index].author.toString(),
                image: _apiResponse.data[index].urlToImage != null
                    ? _apiResponse.data[index].urlToImage.toString()
                    : "https://www.nmaer.com/sysimg/news-news-image.png",
                title: _apiResponse.data[index].title.toString(),
                publishedAt: _apiResponse.data[index].publishedAt.toString(),
                url: _apiResponse.data[index].url.toString(),
                themeContext: widget.themeContext,
              );
            },
            itemCount: _apiResponse.data.length,
          );
        },
      ),
    );
  }
}
