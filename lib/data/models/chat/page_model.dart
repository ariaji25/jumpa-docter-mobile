class PageModel {
  PageModel({
    required this.page,
    required this.nextPage,
    required this.limit,
    required this.pageCount,
    required this.total,
  });

  int page;
  int nextPage;
  int limit;
  int pageCount;
  int total;

  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
    page: json["page"],
    nextPage: json["nextPage"],
    limit: json["limit"],
    pageCount: json["pageCount"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "nextPage": nextPage,
    "limit": limit,
    "pageCount": pageCount,
    "total": total,
  };
}