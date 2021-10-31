import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/News/news_bloc.dart';
import 'package:news/Presentation/Widgets/CarouselSliderForNews.dart';
import 'package:news/Presentation/Widgets/SecondaryNewsCard.dart';
import 'package:news/models/NewsForListing.dart';

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
  NewsBloc _newsBloc;

  @override
  void initState() {
    _fetchNews();
    super.initState();
  }

  _fetchNews() async {
    _newsBloc = context.read<NewsBloc>();
    try {
      _newsBloc.add(
        GetNewsEvent(category: widget.category, field: widget.sub),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _newsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext currentContext) {
    var _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    ThemeData _currentTheme = Theme.of(widget.themeContext);

    return Container(
      color: _currentTheme.primaryColor,
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsInitial) {
            return errorNews(errorMessage: "No News found");
          } else if (state is NewsLoading) {
            return loadingNews();
          } else if (state is NewsLoaded) {
            List<NewsForListing> newsList = state.apiResponse.data;
            if (newsList.length == 0) {
              return errorNews(errorMessage: "No News found");
            }
            return allNews(isPortrait: _isPortrait, newsList: newsList);
          }
          if (state is NewsError) {
            return errorNews(errorMessage: state.errorMessage);
          } else {
            return errorNews(errorMessage: "some unexpected error");
          }
        },
      ),
    );
  }

  Widget errorNews({String errorMessage}) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/errorImage.png',
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height * 0.3,
          ), // author Icongeek26
          Text(errorMessage,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
        ],
      ),
    );
  }

  Widget loadingNews() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget allNews({bool isPortrait, List<NewsForListing> newsList}) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 3, color: Colors.grey),
      itemBuilder: (BuildContext context, int index) {
        if (index < 1) {
          if (isPortrait) {
            return CarouselSliderForNews(
                newsList: newsList, themeContext: widget.themeContext);
          } else {
            return Container();
          }
        }
        return SecondaryNewsCard(
          source: newsList[index].source.toString(),
          author: newsList[index].author.toString(),
          image: (newsList[index].urlToImage == null &&
                  newsList[index].urlToImage.toString().contains('file:'))
              ? "https://www.nmaer.com/sysimg/news-news-image.png"
              : newsList[index].urlToImage.toString(),
          title: newsList[index].title.toString(),
          publishedAt: newsList[index].publishedAt.toString(),
          url: newsList[index].url.toString(),
          themeContext: widget.themeContext,
        );
      },
      itemCount: newsList.length,
    );
  }
}
