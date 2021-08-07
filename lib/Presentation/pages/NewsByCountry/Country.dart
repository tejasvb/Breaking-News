import 'package:flutter/material.dart';
import 'package:news/Presentation/Widgets/TileCountry.dart';



class Country extends StatelessWidget {
  final BuildContext themeContext;
 const Country({@required this.themeContext});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country',
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Theme.of(themeContext).primaryColor,
          title: Text(
            " Country ",
            style: TextStyle(fontFamily: 'ViaodaLibre',color: Theme.of(themeContext).accentColor),
          ),
        ),
        body: Container(
          color: Theme.of(themeContext).primaryColor,
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 8.0,
            children: List.generate(listCountry.length, (index) {
              return Center(
                child: TileCountry(
                    name: listCountry[index].title,
                    url: listCountry[index].url,
                    sub: listCountry[index].sub,
                  themeContext  : themeContext,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class ListCountry {
  const ListCountry({this.title, this.url, this.sub});
  final String title;
  final String url;
  final String sub;
}

const List<ListCountry> listCountry = const <ListCountry>[
  const ListCountry(
      title: 'Argentina',
      url: 'http://mapsopensource.com/images/flag-of-argentina.gif',
      sub: 'ar'),
  const ListCountry(
      title: 'Australia',
      url: 'http://mapsopensource.com/images/flag-of-australia.gif',
      sub: 'au'),
  const ListCountry(
      title: 'Austria',
      url: 'http://mapsopensource.com/images/flag-of-austria.gif',
      sub: 'at'),
  const ListCountry(
      title: 'Belgium',
      url: 'http://mapsopensource.com/images/flag-of-belgium.gif',
      sub: 'be'),
  const ListCountry(
      title: 'Brazil',
      url: 'http://mapsopensource.com/images/flag-of-brazil.gif',
      sub: 'br'),
  const ListCountry(
      title: 'Bulgaria',
      url: 'http://mapsopensource.com/images/flag-of-bulgaria.gif',
      sub: 'bg'),
  const ListCountry(
      title: 'Canada',
      url: 'http://mapsopensource.com/images/flag-of-canada.gif',
      sub: 'ca'),
  const ListCountry(
      title: 'China',
      url:
          'http://mapsopensource.com/images/flag-of-the-peoples-republic-of-china.gif',
      sub: 'cn'),
  const ListCountry(
      title: 'Colombia',
      url: 'http://mapsopensource.com/images/flag-of-colombia.gif',
      sub: 'co'),
  const ListCountry(
      title: 'Cuba',
      url: 'http://mapsopensource.com/images/flag-of-cuba.gif',
      sub: 'cu'),
  const ListCountry(
      title: 'Czech Republic',
      url: 'http://mapsopensource.com/images/flag-of-czech-republic.gif',
      sub: 'cz'),
  const ListCountry(
      title: 'Egypt',
      url: 'http://mapsopensource.com/images/flag-of-egypt.gif',
      sub: 'eg'),
  const ListCountry(
      title: 'France',
      url: 'http://mapsopensource.com/images/flag-of-france.gif',
      sub: 'fr'),
  const ListCountry(
      title: 'Germany',
      url: 'http://mapsopensource.com/images/flag-of-germany.gif',
      sub: 'de'),
  const ListCountry(
      title: 'Greece',
      url: 'http://mapsopensource.com/images/flag-of-greece.gif',
      sub: 'gr'),
  const ListCountry(
      title: 'Hong Kong',
      url: 'http://mapsopensource.com/images/flag-of-hong-kong.gif',
      sub: 'hk'),
  const ListCountry(
      title: 'Hungary',
      url: 'http://mapsopensource.com/images/flag-of-hungary.gif',
      sub: 'hu'),
  const ListCountry(
      title: 'India',
      url: 'http://mapsopensource.com/images/flag-of-india.gif',
      sub: 'in'),
  const ListCountry(
      title: 'Indonesia',
      url: 'http://mapsopensource.com/images/flag-of-indonesia.gif',
      sub: 'id'),
  const ListCountry(
      title: 'Ireland',
      url: 'http://mapsopensource.com/images/flag-of-ireland.gif',
      sub: 'ie'),
  const ListCountry(
      title: 'Israel',
      url: 'http://mapsopensource.com/images/flag-of-israel.gif',
      sub: 'il'),
  const ListCountry(
      title: 'Italy',
      url: 'http://mapsopensource.com/images/flag-of-italy.gif',
      sub: 'it'),
  const ListCountry(
      title: 'Japan',
      url: 'http://mapsopensource.com/images/flag-of-japan.gif',
      sub: 'jp'),
  const ListCountry(
      title: 'Latvia',
      url: 'http://mapsopensource.com/images/flag-of-latvia.gif',
      sub: 'lv'),
  const ListCountry(
      title: 'Lithuania',
      url: 'http://mapsopensource.com/images/flag-of-lithuania.gif',
      sub: 'lt'),
  const ListCountry(
      title: 'Malaysia',
      url: 'http://mapsopensource.com/images/flag-of-malaysia.gif',
      sub: 'my'),
  const ListCountry(
      title: 'Mexico',
      url: 'http://mapsopensource.com/images/flag-of-mexico.gif',
      sub: 'mx'),
  const ListCountry(
      title: 'Morocco',
      url: 'http://mapsopensource.com/images/flag-of-morocco.gif',
      sub: 'ma'),
  const ListCountry(
      title: 'Netherlands',
      url: 'http://mapsopensource.com/images/flag-of-netherlands.gif',
      sub: 'nl'),
  const ListCountry(
      title: 'New Zealand',
      url: 'http://mapsopensource.com/images/flag-of-new-zealand.gif',
      sub: 'nz'),
  const ListCountry(
      title: 'Nigeria',
      url: 'http://mapsopensource.com/images/flag-of-nigeria.gif',
      sub: 'ng'),
  const ListCountry(
      title: 'Norway',
      url: 'http://mapsopensource.com/images/flag-of-norway.gif',
      sub: 'no'),
  const ListCountry(
      title: 'Philippines',
      url: 'http://mapsopensource.com/images/flag-of-the-philippines.gif',
      sub: 'ph'),
  const ListCountry(
      title: 'Poland',
      url: 'http://mapsopensource.com/images/flag-of-poland.gif',
      sub: 'pl'),
  const ListCountry(
      title: 'Portugal',
      url: 'http://mapsopensource.com/images/flag-of-portugal.gif',
      sub: 'pt'),
  const ListCountry(
      title: 'Romania',
      url: 'http://mapsopensource.com/images/flag-of-romania.gif',
      sub: 'ro'),
  const ListCountry(
      title: 'Russia',
      url: 'http://mapsopensource.com/images/flag-of-russia.gif',
      sub: 'ru'),
  const ListCountry(
      title: 'Saudi Arabia',
      url: 'http://mapsopensource.com/images/flag-of-saudi-arabia.gif',
      sub: 'sa'),
  const ListCountry(
      title: 'Serbia',
      url: 'http://mapsopensource.com/images/flag-of-serbia.gif',
      sub: 'rs'),
  const ListCountry(
      title: 'Singapore',
      url: 'http://mapsopensource.com/images/flag-of-singapore.gif',
      sub: 'sg'),
  const ListCountry(
      title: 'Slovakia',
      url: 'http://mapsopensource.com/images/flag-of-slovakia.gif',
      sub: 'sk'),
  const ListCountry(
      title: 'Slovenia',
      url: 'http://mapsopensource.com/images/flag-of-slovenia.gif',
      sub: 'si'),
];
