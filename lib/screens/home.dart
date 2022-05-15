import 'package:flutter/material.dart';
import 'package:newsapp/provider/news_provider.dart';
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
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () =>
                    showSearch(context: context, delegate: NewsSearch()),
                icon: const Icon(Icons.search))
          ],
          title: Text(Provider.of<NP>(context)
              .categories[Provider.of<NP>(context).screenindex])),
      drawer: const NewsDrawer(),
      body: CategoryPage(category: cate.elementAt(index)),
    );
  }
}
