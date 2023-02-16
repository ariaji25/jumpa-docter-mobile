import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/articles/article_entites.dart';
import 'package:jd_mobile/domain/entities/tag/tag_entities.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<ArticlesEntities>>> getArticles(
    int page,
    int? limit,
    String? tag,
    String? search,
  );

  Future<Either<Failure, TagEntities>> getTags();
}
