import 'package:flutter/material.dart';
import 'package:newsapp/models/articles.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:newsapp/screens/widgets/article_item.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  final String category;
  const CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allNews = Provider.of<NP>(context).stories;
    var stories = [];

    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 400), () {
        if (allNews != null) {
          NewsCategory g = allNews.AllNews.firstWhere(
              (NewsCategory element) => element.category == category);
          stories = g.stories;
        }
      }),
      builder: (context, snapshot) => Scaffold(
        body: ListView(
          children: [
            if (stories.isEmpty)
              const Center(
                child: LinearProgressIndicator(
                  color: Colors.yellow,
                  backgroundColor: Colors.black,
                ),
              ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Top Headlines",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            if (stories.isNotEmpty) ...stories.map((e) => ArticleItem(item: e)),
          ],
        ),
      ),
    );
  }
}
