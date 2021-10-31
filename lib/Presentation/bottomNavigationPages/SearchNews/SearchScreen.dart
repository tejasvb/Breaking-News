import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/News/news_bloc.dart';
import 'package:news/Presentation/Widgets/SecondaryNewsCard.dart';
import 'package:news/models/NewsForListing.dart';
import 'package:provider/src/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with AutomaticKeepAliveClientMixin {


  final search = TextEditingController(text: '');
  NewsBloc _newsBloc;

  @override
  void initState() {
    _newsBloc = context.read<NewsBloc>();
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  _fetchNews(String search) async {
    if(search.toLowerCase().trim().isEmpty) return
    _newsBloc.add(GetNewsEvent(query: search,type:"everything"));
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
                                      _fetchNews(value);
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
            BlocBuilder<NewsBloc, NewsState>(
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
                  if (search.text.trim().isEmpty) return Container();
                  return allNews(newsList:newsList);

                }
                if (state is NewsError) {
                  return errorNews(errorMessage: state.errorMessage);
                } else {
                  return errorNews(errorMessage: "No News found");
                }
              },
            ),
          ],
        ),
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
        child: CircularProgressIndicator(
          color: _currentTheme.accentColor,
        ));
  }

  Widget allNews({List<NewsForListing> newsList}) {
    return ListView.separated(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (BuildContext _, int index) => Divider(
          height: 3, color: _currentTheme.secondaryHeaderColor),
      itemBuilder: (BuildContext _, int index) {
        return SecondaryNewsCard(
          source: newsList[index].source.toString(),
          author: newsList[index].author.toString(),
          image: newsList[index].urlToImage != null
              ? newsList[index].urlToImage.toString()
              : "https://www.nmaer.com/sysimg/news-news-image.png",
          title: newsList[index].title.toString(),
          publishedAt:
          newsList[index].publishedAt.toString(),
          url: newsList[index].url.toString(),
          themeContext: context,
        );
      },
      itemCount: newsList.length,
    );
  }
  @override
  bool get wantKeepAlive => true;
}
