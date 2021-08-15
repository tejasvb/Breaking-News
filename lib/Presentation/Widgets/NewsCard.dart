import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final String author;
  final String title;
  final String publishedAt;
  final String source;
  final String image;

  final String url;
  final BuildContext themeContext;

  const NewsCard(
      {this.author,
      this.title,
      this.image,
      this.publishedAt,
      this.source,
      this.url,
      this.themeContext});
  final Pattern patternDate = '[0-9]{4}-[0-9]{2}-[0-9]{2}';
  @override
  Widget build(BuildContext context) {
   final textSize = MediaQuery.of(context).size.height*0.001;
    bool check;
    String name;
    ThemeData _currentTheme = Theme.of(themeContext);
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
        child: Container(
          color: _currentTheme.primaryColor,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 4,
                  placeholder: "assets/images/news-news-image.png",
                  image: image,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: _currentTheme.accentColor,
                        fontSize: textSize*21,
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
                            strutStyle: StrutStyle(fontSize: textSize*14),
                            text: TextSpan(
                                style: TextStyle(
                                    color: _currentTheme.secondaryHeaderColor),
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
                          size: textSize*13,
                          color: _currentTheme.secondaryHeaderColor,
                        ),
                      if (check)
                        SizedBox(
                          width: 4,
                        ),
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          strutStyle: StrutStyle(fontSize: textSize*14),
                          text: TextSpan(
                              style: TextStyle(
                                color: _currentTheme.secondaryHeaderColor,
                              ),
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
        ),
      ),
    );
  }
}
