class NewsForListing {
  String id;
  String source;
  String author;
  String title;
  String description;
  Uri url;
  Uri urlToImage;
  String publishedAt;
  String content;

  NewsForListing(
      {this.id,
      this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory NewsForListing.fromJson(Map<String, dynamic> item) {
    return NewsForListing(
      id: item['source']['id'].toString() != null
          ? item['source']['id'].toString()
          : null,
      source: item['source']['name'].toString() != null
          ? item['source']['name'].toString()
          : null,
      author:
          item['author'].toString() != null ? item['author'].toString() : null,
      title: item['title'].toString() != null ? item['title'].toString() : null,
      description: item['description'].toString() != null
          ? item['description'].toString()
          : null,
      url: item['url'] != null ? Uri.parse(item['url']) : null,
      urlToImage:
          item['urlToImage'] != null ? Uri.parse(item['urlToImage']) : null,
      publishedAt: item['publishedAt'].toString() != null
          ? item['publishedAt'].toString()
          : null,
      content: item['content'].toString() != null
          ? item['content'].toString()
          : null,
    );
  }
}
