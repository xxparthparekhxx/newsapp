import 'dart:convert' show utf8;

class Article {
  final String? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;
  Article(this.source, this.author, this.title, this.description, this.url,
      this.urlToImage, this.publishedAt, this.content);
  static Article fromjson(Map a) {
    return Article(
        (a['source'] as Map)['name'],
        a['author'],
        utf8.decode((a['title'] as String).runes.toList()),
        a['description'],
        a['url'],
        a['urlToImage'],
        DateTime.tryParse(a['publishedAt']),
        a['content']);
  }
}

class NewsCategory {
  final String category;
  final List<Article> stories;
  NewsCategory(this.category, this.stories);
  static NewsCategory fromjson(String Category, List articles) {
    return NewsCategory(
        Category, articles.map((a) => Article.fromjson(a)).toList());
  }
}

class News {
  final List<NewsCategory> AllNews;
  News(this.AllNews);
}
