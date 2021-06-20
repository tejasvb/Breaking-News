import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final String author;
  final String title;
  final String publishedAt;
  final String source;
  final String image;
  final String content;
  final String url;

  NewsCard(
      {this.author,
      this.title,
      this.image,
      this.publishedAt,
      this.source,
      this.content,
      this.url});

  @override
  Widget build(BuildContext context) {
    bool check;
    String name;
    Pattern patternDate = '[0-9]{4}-[0-9]{2}-[0-9]{2}';
    RegExp regexDate = new RegExp(patternDate);
    if ((source == null) && (author == null)) {
      check = false;
    } else {
      check = true;
      if (author != null) {
        name = source;
      } else {
        name = author;
      }
    }

    var date = regexDate.firstMatch(publishedAt.toString()).group(0);

    return GestureDetector(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url, forceSafariVC: true, forceWebView: true);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OrientationBuilder(builder: (context, orientation) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  FadeInImage(
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 4,
                    // here `bytes` is a Uint8List containing the bytes for the in-memory image
                    placeholder: NetworkImage('https://www.nmaer.com/sysimg/news-news-image.png'),
                    image: NetworkImage( image),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'PlayfairDisplay'),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (check)
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              strutStyle: StrutStyle(fontSize: 14.0),
                              text: TextSpan(
                                  style: TextStyle(color: Colors.grey[700]),
                                  text: name),
                            ),
                          ),
                        if (check)
                          SizedBox(
                            width: 4,
                          ),
                        if (check)
                          Icon(
                            Icons.fiber_manual_record,
                            size: 14,
                            color: Colors.grey,
                          ),
                        if (check)
                          SizedBox(
                            width: 4,
                          ),
                        Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            strutStyle: StrutStyle(fontSize: 13.0),
                            text: TextSpan(
                                style: TextStyle(color: Colors.grey[700]),
                                text: date),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
