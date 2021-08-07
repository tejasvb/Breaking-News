import 'package:flutter/material.dart';
import 'package:news/Presentation/bottomNavigationPages/SavedNews/SavedArticle.dart';
import 'package:news/Presentation/bottomNavigationPages/SearchNews/SearchScreen.dart';
import 'package:news/Presentation/bottomNavigationPages/specificCountryNews/SpecificCountryNews.dart';




class HomePage extends StatefulWidget {
  static List<Widget> _widgetOptions = <Widget>[
    SpecificCountryNews(
      url: 'http://mapsopensource.com/images/flag-of-india.gif',
      name: 'india',
      sub: 'in',
    ),
    SearchScreen(),
    SavedArticle(),
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).accentColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'Top HeadLine',
              tooltip: "Top HeadLine",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              tooltip: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              label: 'Saved',
              tooltip: "Profile",
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          iconSize: 20,
          onTap: _onItemTapped,
          elevation: 5),
      body:IndexedStack(
        children:  HomePage._widgetOptions,
        index: _selectedIndex,
      ),
    );
  }
}
