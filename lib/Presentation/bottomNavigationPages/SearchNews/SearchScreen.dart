import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news/Presentation/Widgets/SecondaryNewsCard.dart';

import 'package:news/models/NewsForListing.dart';
import 'package:news/models/api_response.dart';
import 'package:news/service/news_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with AutomaticKeepAliveClientMixin {
  NewsService get service => GetIt.I<NewsService>();

  final search = TextEditingController(text: '');
  APIResponse<List<NewsForListing>> _apiResponse;

  bool _isLoading = false;

  @override
  void initState() {
    _fetchNews(search.text);
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  _fetchNews(String search) async {
    if(search.toLowerCase().trim().isEmpty) return
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNewsList(
        type: "everything", query: search.toLowerCase().trim());

    setState(() {
      _isLoading = false;
    });
  }

  ThemeData _currentTheme;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _currentTheme = Theme.of(context);
    return Container(
      color: _currentTheme.primaryColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top:48.0,bottom:8.0,left:8.0,right: 8.0),
                      child: SizedBox(
                        height: 70,
                        child: TextField(
                                  cursorColor:
                                  _currentTheme.secondaryHeaderColor,
                                  autofocus: true,
                                  style: TextStyle(
                                      color: _currentTheme.accentColor,
                                      fontSize: 20),
                                  maxLines: 1,
                                  controller: search,
                                  maxLength: 15,
                                  onSubmitted: (value) {
                                    setState(() {
                                      _fetchNews(search.text);
                                    });
                                  },
                                  cursorRadius: Radius.circular(30),
                                  decoration: InputDecoration(
                                    hintText: 'search...',
                                    alignLabelWithHint: true,
                                    hintStyle: TextStyle(
                                        color:
                                        _currentTheme.secondaryHeaderColor,
                                        fontSize: 20),
                                    prefixIcon: Icon(Icons.search,
                                        color: _currentTheme.accentColor),
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          search.clear();
                                        },
                                        child: Icon(Icons.clear,
                                            color: _currentTheme.accentColor)),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: _currentTheme.accentColor,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    focusColor: _currentTheme.accentColor,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _currentTheme.accentColor,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  )),
                      ),
                    ),
                  ),
            Builder(
              builder: (BuildContext _) {
                if (search.text.trim().isEmpty) return Container();

                if (_isLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: _currentTheme.accentColor,
                  ));
                }

                if (_apiResponse.error) {
                  return Text(_apiResponse.errorMessage);
                }
                if (_apiResponse.data != null) {
                  return ListView.separated(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext _, int index) => Divider(
                        height: 3, color: _currentTheme.secondaryHeaderColor),
                    itemBuilder: (BuildContext _, int index) {
                      return SecondaryNewsCard(
                        source: _apiResponse.data[index].source.toString(),
                        author: _apiResponse.data[index].author.toString(),
                        image: _apiResponse.data[index].urlToImage != null
                            ? _apiResponse.data[index].urlToImage.toString()
                            : "https://www.nmaer.com/sysimg/news-news-image.png",
                        title: _apiResponse.data[index].title.toString(),
                        publishedAt:
                            _apiResponse.data[index].publishedAt.toString(),
                        url: _apiResponse.data[index].url.toString(),
                        themeContext: context,
                      );
                    },
                    itemCount: _apiResponse.data.length,
                  );
                }
                return Center(
                  child: Text("no articles has found"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
