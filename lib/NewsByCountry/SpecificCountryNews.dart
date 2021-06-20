import 'package:flutter/material.dart';
import 'package:news/NewsByCountry/Country.dart';

import 'package:news/Widgets/Content.dart';


class SpecificCountryNews extends StatefulWidget {
  final String url;
  final String name;
  final String sub;

  SpecificCountryNews({this.url, this.name, this.sub});

  @override
  _SpecificCountryNewsState createState() => _SpecificCountryNewsState();
}

class _SpecificCountryNewsState extends State<SpecificCountryNews> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'News App',
        home: DefaultTabController(
          length: 7,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,

              bottom: TabBar(
                labelColor: Colors.black,
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
                style:
                    TextStyle(fontFamily: 'PlayfairDisplay',color: Colors.black),
              ),
              actions: [
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                        icon: Icon(
                          Icons.public_outlined,
                          color: Colors.black,

                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Country(),
                              ));
                        });
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
                    category: 'general'),
                Content(
                    url: widget.url,
                    name: widget.name,
                    sub: widget.sub,
                    category: 'business'),
                Content(
                    url: widget.url,
                    name: widget.name,
                    sub: widget.sub,
                    category: 'entertainment'),
                Content(
                    url: widget.url,
                    name: widget.name,
                    sub: widget.sub,
                    category: 'health'),
                Content(
                    url: widget.url,
                    name: widget.name,
                    sub: widget.sub,
                    category: 'science'),
                Content(
                    url: widget.url,
                    name: widget.name,
                    sub: widget.sub,
                    category: 'sports'),
                Content(
                    url: widget.url,
                    name: widget.name,
                    sub: widget.sub,
                    category: 'technology'),
              ],
            ),
          ),
        ));
  }
}
