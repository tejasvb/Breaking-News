import 'package:flutter/material.dart';
import 'package:news/Presentation/Widgets/Content.dart';
import 'package:news/Presentation/pages/NewsByCountry/Country.dart';


class SpecificCountryNews extends StatefulWidget {
  final String url;
  final String name;
  final String sub;
  final BuildContext themeContext;

  const SpecificCountryNews(
      {@required this.url,
      @required this.name,
      @required this.sub,
      this.themeContext});

  @override
  _SpecificCountryNewsState createState() => _SpecificCountryNewsState();
}

class _SpecificCountryNewsState extends State<SpecificCountryNews> with AutomaticKeepAliveClientMixin{
  ThemeData _currentTheme;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    BuildContext themeContext =
        (widget.themeContext != null) ? widget.themeContext : context;
    _currentTheme = Theme.of(themeContext);
    return MaterialApp(
        title: 'News App',
        home: DefaultTabController(
          length: 7,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: _currentTheme.primaryColor,
              centerTitle: true,
              bottom: TabBar(
                labelColor: _currentTheme.accentColor,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: 'General',
                  ),
                  Tab(
                    text: 'Business',
                  ),
                  Tab(
                    text: 'Entertainment',
                  ),
                  Tab(
                    text: 'Health',
                  ),
                  Tab(
                    text: 'Science',
                  ),
                  Tab(
                    text: 'Sports',
                  ),
                  Tab(
                    text: 'Technology',
                  ),
                ],
              ),
              title: Text(
                " News ",
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  color: _currentTheme.accentColor,
                ),
              ),
              actions: [
                Builder(
                  builder: (BuildContext context1) {
                    return IconButton(
                      icon: Hero(
                        tag: "listCountry",
                        child: Icon(
                          Icons.public_outlined,
                          color: _currentTheme.accentColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context1,
                            MaterialPageRoute(
                              builder: (context1) => Country(
                                themeContext: themeContext,
                              ),
                            ));
                      },
                    );
                  },
                ),
              ],
            ),
            body: TabBarView(
              children: [
                Content(
                    url: widget.url,
                    name: widget.name,
                    sub: widget.sub,
                    themeContext: themeContext,
                    category: 'general'),
                Content(
                    url: widget.url,
                    name: widget.name,
                    sub: widget.sub,
                    themeContext: themeContext,
                    category: 'business'),
                Content(
                    url: widget.url,
                    name: widget.name,
                    sub: widget.sub,
                    themeContext: themeContext,
                    category: 'entertainment'),
                Content(
                    url: widget.url,
                    name: widget.name,
                    sub: widget.sub,
                    themeContext: themeContext,
                    category: 'health'),
                Content(
                    url: widget.url,
                    name: widget.name,
                    sub: widget.sub,
                    themeContext: themeContext,
                    category: 'science'),
                Content(
                    url: widget.url,
                    name: widget.name,
                    sub: widget.sub,
                    themeContext: themeContext,
                    category: 'sports'),
                Content(
                    url: widget.url,
                    name: widget.name,
                    sub: widget.sub,
                    themeContext: themeContext,
                    category: 'technology'),
              ],
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
