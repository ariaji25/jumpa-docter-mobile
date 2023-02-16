import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:dartz/dartz.dart';
import 'package:jd_mobile/data/datasources/articles/article_api.dart';
import 'package:jd_mobile/data/models/articles/article_model.dart';
import 'package:jd_mobile/domain/entities/tag/tag_entities.dart';
import 'package:jd_mobile/domain/entities/articles/article_entites.dart';
import 'package:jd_mobile/domain/repositories/articles/articles_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final ArticleApi api;
  ArticleRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, List<ArticlesEntities>>> getArticles(int page, int? limit, String? tag, String? search) async {
   try {
      final result = await api.getArticles(page, limit, tag, search);
      return Right(result["data"]['articles']);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }

  @override
  Future<Either<Failure, List<TagEntities>>> getTags() async {
    try {
      final result = await api.getTags();
      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }
}