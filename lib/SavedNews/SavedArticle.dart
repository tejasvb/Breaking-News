import 'dart:io';
import 'package:flutter/material.dart';
import 'package:news/Widgets/secondaryNewsWidget.dart';
import 'package:path_provider/path_provider.dart';

class Data {
  String author;
  String title;
  String publishedAt;
  String source;
  String image;
  String content;
  String url;

  Data(
      {this.author,
      this.title,
      this.publishedAt,
      this.source,
      this.image,
      this.url,
      this.content});
}

class SavedArticle extends StatefulWidget {
  @override
  _SavedArticleState createState() => _SavedArticleState();
}

class _SavedArticleState extends State<SavedArticle> {
  List<Widget> getData = <Widget>[];

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Saved Articles",
            style:
                TextStyle(fontFamily: 'PlayfairDisplay', color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: FutureBuilder(
            future: _read(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                for (int i = 2; i < 100; i++) {
                  try {
                    String author;
                    String title;
                    String publishedAt;
                    String source;
                    String image;
                    String content;
                    String url;
                    String str = _getText(snapshot.data[i]);
                    String start = "title:";
                    String end = ", image:";
                    int startIndex = str.indexOf(start);

                    int endIndex = str.indexOf(end);
                    if (endIndex != -1 && startIndex != -1)
                      title = str.substring(
                          startIndex + (start.length + 1), endIndex);

                    start = "author:";
                    end = ", title:";
                    startIndex = str.indexOf(start);
                    endIndex = str.indexOf(end);

                    if (endIndex != -1 && startIndex != -1)
                      author =
                          str.substring(startIndex + (start.length), endIndex);

                    start = "image:";
                    end = ", publishedAt:";
                    startIndex = str.indexOf(start);
                    endIndex = str.indexOf(end);

                    if (endIndex != -1 && startIndex != -1)
                      image = str.substring(
                          startIndex + (start.length + 1), endIndex);
                    start = "publishedAt:";
                    end = ", source:";
                    startIndex = str.indexOf(start);
                    endIndex = str.indexOf(end);

                    if (endIndex != -1 && startIndex != -1)
                      publishedAt = str.substring(
                          startIndex + (start.length - 1), endIndex);

                    start = "source:";
                    end = ", content:";
                    startIndex = str.indexOf(start);
                    endIndex = str.indexOf(end);

                    if (endIndex != -1 && startIndex != -1)
                      source = str.substring(startIndex + 8, endIndex);

                    start = ", url:";

                    startIndex = str.indexOf(start);

                    if (endIndex != -1 && startIndex != -1)
                      url = str.substring(
                          startIndex + (start.length + 1), str.length - 1);

                    getData.add(SecondaryNewsWidget(
                        source: source.toString(),
                        author: author.toString(),
                        image: image != null
                            ? image.toString()
                            : "https://www.nmaer.com/sysimg/news-news-image.png",
                        title: title.toString(),
                        publishedAt: publishedAt.toString(),
                        content: content.toString(),
                        url: url.toString()));
                  } catch (e) {
                    return ListView(
                      physics: ScrollPhysics(),
                      children: getData,
                    );
                  }
                }
              }

              return Text(" ");
            },
          ),
        ),
      ),
    );
  }
}
