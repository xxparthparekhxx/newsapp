import 'package:flutter/material.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:newsapp/screens/widgets/drawer_item.dart';
import 'package:provider/provider.dart';

class NewsDrawer extends StatelessWidget {
  const NewsDrawer({Key? key}) : super(key: key);
  final List<Map<String, Object>> items = const [
    {
      "name": "Top Stories",
      "icon": Icons.remove_red_eye_rounded,
    },
    {
      "name": "India",
      "icon": Icons.flag,
    },
    {
      "name": "World",
      "icon": Icons.public,
    },
    {
      "name": "Business",
      "icon": Icons.business,
    },
    {
      "name": "Technology",
      "icon": Icons.satellite_alt_sharp,
    },
    {"name": "Entertainment", "icon": Icons.local_movies_rounded},
    {
      "name": "Sports",
      "icon": Icons.directions_bike_rounded,
    },
    {"name": "Science", "icon": Icons.biotech_outlined},
    {
      "name": "Health",
      "icon": Icons.health_and_safety_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    int i = Provider.of<NP>(context).screenindex;
    return Drawer(
      child: ListView(controller: ScrollController(), children: [
        SizedBox(
            height: 200, width: 200, child: Center(child: Text("Weather"))),
        Column(children: [
          for (int index = 0; index < items.length; index++)
            DrawerItem(
                iconData: items[index]["icon"] as IconData,
                text: items[index]["name"] as String,
                index: index,
                selected: index == i),
        ]),
      ]),
    );
  }
}
