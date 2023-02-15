// ignore_for_file: depend_on_referenced_packages, overridden_fields, annotate_overrides

import 'package:jd_mobile/domain/entities/articles/article_entites.dart';
import 'package:json_annotation/json_annotation.dart';
part 'article_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  createToJson: true,
  fieldRename: FieldRename.snake,
)
class ArticlesModel extends ArticlesEntities {
  ArticlesModel({
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

  factory ArticlesModel.fromJson(Map<String, dynamic> json) =>
      _$ArticlesModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesModelToJson(this);
}
