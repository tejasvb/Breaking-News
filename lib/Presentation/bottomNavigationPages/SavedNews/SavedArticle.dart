import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:news/Presentation/Widgets/SecondaryNewsCard.dart';
import 'package:path_provider/path_provider.dart';

class Data {
  String author;
  String title;
  String publishedAt;
  String source;
  String image;
  String url;

  Data({
    this.author,
    this.title,
    this.publishedAt,
    this.source,
    this.image,
    this.url,
  });
}

class SavedArticle extends StatefulWidget {

  @override
  _SavedArticleState createState() => _SavedArticleState();
}

class _SavedArticleState extends State<SavedArticle> with AutomaticKeepAliveClientMixin{
  Map<String, dynamic> getData;
  List<Map<String, dynamic>> listOfData = [];
  ThemeData _currentTheme;

  String _getText(File file) {
    String text = file.readAsStringSync();
    return text;
  }

  _read() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return directory.listSync();
    } catch (e) {
      print("Couldn't read file");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _currentTheme = Theme.of(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: _currentTheme.primaryColor,
          title: Text(
            "Saved Articles",
            style: TextStyle(
                fontFamily: 'PlayfairDisplay',
                color: _currentTheme.accentColor),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: _currentTheme.primaryColor,
          child: FutureBuilder(
            future: _read(),
            builder: (BuildContext _, AsyncSnapshot<dynamic> snapshot) {
              if (listOfData != null) {
                listOfData.clear();
              }
              if (snapshot.hasData) {
                int i = 0;
                while (true) {
                  try {
                    String str = _getText(snapshot.data[i]);
                    final jsonData = jsonDecode(str);
                    getData = {
                      'source': jsonData['source'],
                      'author': jsonData['author'],
                      'image': jsonData['image'] != null
                          ? jsonData['image'].toString()
                          : "https://www.nmaer.com/sysimg/news-news-image.png",
                      'title': jsonData['title'].toString(),
                      'publishedAt': jsonData['publishedAt'].toString(),
                      'url': jsonData['url'].toString(),
                      'themeContext': context,
                    };
                    listOfData.add(getData);
                  } catch (e) {
                    return ListView.builder(
                        itemCount: listOfData.length,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext _, int index) {
                          return SecondaryNewsCard(
                            source: listOfData[index]['source'],
                            author: listOfData[index]['author'],
                            image: listOfData[index]['image']!=null
                                ? listOfData[index]['image']
                                : "https://www.nmaer.com/sysimg/news-news-image.png",
                            title: listOfData[index]['title'],
                            publishedAt: listOfData[index]['publishedAt'],
                            url: listOfData[index]['url'],
                            themeContext: context,
                          );
                        },
                    );
                  }
                  i++;
                }
              }

              return Text(" ");
            },
          ),
        ),
      ),
    );
  }

  @override

  bool get wantKeepAlive => false;

}


