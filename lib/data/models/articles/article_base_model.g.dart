// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleBaseModel _$ArticleBaseModelFromJson(Map<String, dynamic> json) =>
    ArticleBaseModel(
      limit: json['limit'] as int?,
      previousPage: json['previous_page'] as int?,
      currentPage: json['current_page'] as int?,
      nextPage: json['next_page'] as int?,
      total: json['total'] as int?,
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => ArticlesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleBaseModelToJson(ArticleBaseModel instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'previous_page': instance.previousPage,
      'current_page': instance.currentPage,
      'next_page': instance.nextPage,
      'total': instance.total,
      'articles': instance.articles?.map((e) => e.toJson()).toList(),
    };
