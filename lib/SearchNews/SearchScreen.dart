import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news/Widgets/secondaryNewsWidget.dart';
import 'package:news/models/NewsForListing.dart';
import 'package:news/models/api_response.dart';
import 'package:news/service/news_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  NewsService get service => GetIt.I<NewsService>();

  final search = TextEditingController(text: ' ');
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
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNewsList(
        type: "everything", query: search.toLowerCase());

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 70,
                        child: TextField(
                            cursorColor: Colors.grey,
                            autofocus: true,
                            style: TextStyle(color: Colors.black, fontSize: 20),
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
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.black),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    search.clear();
                                  },
                                  child:
                                      Icon(Icons.clear, color: Colors.black)),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              focusColor: Colors.black,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Builder(
              builder: (BuildContext context) {
                if (search.text.trim().isEmpty) return Container();

                if (_isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (_apiResponse.error) {
                  return Text(_apiResponse.errorMessage);
                }
                if (_apiResponse.data != null) {
                  return ListView.separated(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(height: 3, color: Colors.grey),
                    itemBuilder: (BuildContext context, int index) {
                      return SecondaryNewsWidget(
                          source: _apiResponse.data[index].source.toString(),
                          author: _apiResponse.data[index].author.toString(),
                          image: _apiResponse.data[index].urlToImage != null
                              ? _apiResponse.data[index].urlToImage.toString()
                              : "https://www.nmaer.com/sysimg/news-news-image.png",
                          title: _apiResponse.data[index].title.toString(),
                          publishedAt:
                              _apiResponse.data[index].publishedAt.toString(),
                          content: _apiResponse.data[index].content.toString(),
                          url: _apiResponse.data[index].url.toString());
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
}
