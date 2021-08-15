import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

bool exist = true;

class SecondaryNewsCard extends StatefulWidget {
  final String author;
  final String title;
  final String publishedAt;
  final String source;
  final String image;
  final String url;
  final BuildContext themeContext;

  SecondaryNewsCard({
    @required this.author,
    @required this.title,
    @required this.image,
    @required this.publishedAt,
    @required this.source,
    @required this.url,
    @required this.themeContext,
  });

  @override
  _SecondaryNewsCardState createState() => _SecondaryNewsCardState();
}

class _SecondaryNewsCardState extends State<SecondaryNewsCard> {
  Future<bool> _doesFileExist(String title) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$title.txt');
    return file.existsSync();
  }

  bool check;
  String name;
  Pattern patternDate = '[0-9]{4}-[0-9]{2}-[0-9]{2}';

  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).orientation == Orientation.portrait
        ? MediaQuery.of(context).size.height * 0.001
        : MediaQuery.of(context).size.width * 0.0012;
    ThemeData _currentTheme = Theme.of(widget.themeContext);
    RegExp regexDate = new RegExp(patternDate);
    if ((widget.source == null) && (widget.author == null)) {
      check = false;
    } else {
      check = true;
      if (widget.author != null) {
        name = widget.source;
      } else {
        name = widget.author;
      }
    }
    String date = " ";
    if (widget.publishedAt.toString().isNotEmpty) {
      date = regexDate.firstMatch('2021-08-06T01:58:23Z').group(0);
    }

    return GestureDetector(
      onTap: () async {
        if (await canLaunch(widget.url)) {
          await launch(widget.url, forceSafariVC: true, forceWebView: true);
        } else {
          throw 'Could not launch ${widget.url}';
        }
      },
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 120,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      style: TextStyle(
                          color: _currentTheme.accentColor,
                          fontSize: textSize * 19,
                          fontFamily: 'PlayfairDisplay'),
                      text: widget.title),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                height: 70,
                width: 100,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: NetworkImage(
                      'https://www.nmaer.com/sysimg/news-news-image.png'),
                  image: NetworkImage(widget.image),
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (check)
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    strutStyle: StrutStyle(fontSize: textSize * 13),
                    text: TextSpan(
                        style: TextStyle(
                          color: _currentTheme.secondaryHeaderColor,
                        ),
                        text: name),
                  ),
                if (check)
                  SizedBox(
                    width: 4,
                  ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 9,
              ),
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: textSize * 13),
                  text: TextSpan(
                      style: TextStyle(
                        color: _currentTheme.secondaryHeaderColor,
                      ),
                      text: date),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              if (!kIsWeb)
                FutureBuilder(
                  future: _doesFileExist(widget.title),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return GestureDetector(
                          onTap: () async {
                            final directory =
                                await getApplicationDocumentsDirectory();
                            final file =
                                File('${directory.path}/${widget.title}.txt');
                            final text = {
                              "author": widget.author,
                              "title": widget.title,
                              "image": widget.image,
                              "publishedAt": widget.publishedAt,
                              "source": widget.source,
                              "url": widget.url,
                            };
                            await file.writeAsString(text.toString());
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: _currentTheme.primaryColor,
                            child: Icon(
                              Icons.bookmark_border,
                              size: 25,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        if (!snapshot.data)
                          return GestureDetector(
                            onTap: () async {
                              final directory =
                                  await getApplicationDocumentsDirectory();
                              final _filePath =
                                  File('${directory.path}/${widget.title}.txt');
                              Map<String, dynamic> articleInfo = {
                                "author": widget.author,
                                "title": widget.title,
                                "image": widget.image,
                                "publishedAt": widget.publishedAt,
                                "source": widget.source,
                                "url": widget.url,
                              };
                              String _jsonString = jsonEncode(articleInfo);
                              await _filePath.writeAsString(_jsonString);
                              setState(() {});
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: _currentTheme.primaryColor,
                              child: Icon(
                                Icons.bookmark_border,
                                size: 25,
                                color: Colors.grey,
                              ),
                            ),
                          );

                        if (exist)
                          return GestureDetector(
                            onTap: () async {
                              final directory =
                                  await getApplicationDocumentsDirectory();
                              final file =
                                  File('${directory.path}/${widget.title}.txt');
                              file.deleteSync();
                              setState(() {});
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: _currentTheme.primaryColor,
                              child: Icon(
                                Icons.bookmark,
                                size: 25,
                                color: Colors.grey,
                              ),
                            ),
                          );
                      }
                    }

                    return Center(
                      child: CircularProgressIndicator(
                        color: _currentTheme.accentColor,
                      ),
                    );
                  },
                ),
              SizedBox(
                width: 20,
              ),
              if (!kIsWeb)
                GestureDetector(
                  onTap: () async {
                    final RenderBox box = context.findRenderObject();
                    await Share.share(widget.url,
                        subject: widget.title,
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: _currentTheme.primaryColor,
                    child: Icon(
                      Icons.share_outlined,
                      size: 25,
                      color: Colors.grey,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
