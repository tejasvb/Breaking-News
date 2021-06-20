import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

bool exist = true;

class SecondaryNewsWidget extends StatefulWidget {
  final String author;
  final String title;
  final String publishedAt;
  final String source;
  final String image;
  final String content;
  final String url;

  SecondaryNewsWidget(
      {this.author,
      this.title,
      this.image,
      this.publishedAt,
      this.source,
      this.content,
      this.url});

  @override
  _SecondaryNewsWidgetState createState() => _SecondaryNewsWidgetState();
}

class _SecondaryNewsWidgetState extends State<SecondaryNewsWidget> {
  Future<bool> _doesFileExist(String title) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$title.txt');
    return file.existsSync();
  }

  @override
  Widget build(BuildContext context) {
    bool check;
    String name;

    Pattern patternDate = '[0-9]{4}-[0-9]{2}-[0-9]{2}';
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

    var date = regexDate.firstMatch(widget.publishedAt.toString()).group(0);

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
                  strutStyle: StrutStyle(fontSize: 14.0),
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'PlayfairDisplay'),
                      text: widget.title),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,top:10),
              child: Container(
                alignment: Alignment.centerLeft,
                height: 70,
                width: 100,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  // here `bytes` is a Uint8List containing the bytes for the in-memory image
                  placeholder: NetworkImage('https://www.nmaer.com/sysimg/news-news-image.png'),
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
                    strutStyle: StrutStyle(fontSize: 14.0),
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey[700]), text: name),
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
                  strutStyle: StrutStyle(fontSize: 13.0),
                  text: TextSpan(
                      style: TextStyle(color: Colors.grey[700]), text: date),
                ),
              ),
              SizedBox(
                width: 20,
              ),
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
                            "content": widget.content,
                            "url": widget.url,
                          };
                          await file.writeAsString(text.toString());
                          setState(() {});
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
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
                            final file =
                                File('${directory.path}/${widget.title}.txt');
                            final text = {
                              "author": widget.author,
                              "title": widget.title,
                              "image": widget.image,
                              "publishedAt": widget.publishedAt,
                              "source": widget.source,
                              "content": widget.content,
                              "url": widget.url,
                            };
                            await file.writeAsString(text.toString());
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
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
                            backgroundColor: Colors.white,
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
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              SizedBox(
                width: 20,
              ),
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
                  backgroundColor: Colors.white,
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
