// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlesModel _$ArticlesModelFromJson(Map<String, dynamic> json) =>
    ArticlesModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      thumbnail: json['thumbnail'] as String?,
      shortDesc: json['short_desc'] as String?,
      body: json['body'] as String?,
      tags: json['tags'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ArticlesModelToJson(ArticlesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'short_desc': instance.shortDesc,
      'body': instance.body,
      'tags': instance.tags,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
