// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:jd_mobile/data/models/articles/article_model.dart';
part 'article_base_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  createToJson: true,
  fieldRename: FieldRename.snake,
)
class ArticleBaseModel {
  ArticleBaseModel({
    this.limit,
    this.previousPage,
    this.currentPage,
    this.nextPage,
    this.total,
    this.articles,
  });

  int? limit;
  int? previousPage;
  int? currentPage;
  int? nextPage;
  int? total;
  List<ArticlesModel>? articles;

  factory ArticleBaseModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleBaseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleBaseModelToJson(this);
}
