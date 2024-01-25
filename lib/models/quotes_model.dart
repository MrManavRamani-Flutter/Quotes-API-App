class Quote {
  String id;
  String author;
  String content;
  String authorSlug;
  Quote({
    required this.id,
    required this.author,
    required this.content,
    required this.authorSlug,
  });
}

late Set<String> favoriteQuotes;
