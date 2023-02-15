class ArticlesEntities {
  ArticlesEntities({
    this.id,
    this.title,
    this.thumbnail,
    this.shortDesc,
    this.body,
    this.tags,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  String? thumbnail;
  String? shortDesc;
  String? body;
  String? tags;
  DateTime? createdAt;
  DateTime? updatedAt;
}
