import 'package:flutter/material.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:newsapp/provider/weather_provider.dart';
import 'package:newsapp/screens/widgets/drawer/news_drawer.dart';
import 'package:newsapp/screens/widgets/news/categorypage.dart';
import 'package:newsapp/screens/widgets/search_deligate.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = Provider.of<NP>(context).screenindex;
    List<String> cate = Provider.of<NP>(context).categories;
    Provider.of<WP>(context, listen: false).isLoading;
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () =>
                    showSearch(context: context, delegate: NewsSearch()),
                icon: const Icon(Icons.search))
          ],
          title: Text(Provider.of<NP>(context)
              .categories[Provider.of<NP>(context).screenindex]
              .replaceAll("_", " ")
              .toTitleCase())),
      drawer: const NewsDrawer(),
      body: CategoryPage(category: cate.elementAt(index)),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
