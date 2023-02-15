import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/articles/article_entites.dart';
import 'package:jd_mobile/domain/entities/base_filter.dart';
import 'package:jd_mobile/domain/repositories/articles/articles_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class GetArticles extends UseCase<Either<Failure, List<ArticlesEntities>>, Tuple3<int, int, BaseFilterEntity>> {
  final ArticleRepository repository;
  GetArticles(this.repository);
  
  @override
  Future<Either<Failure, List<ArticlesEntities>>> call(Tuple3<int, int, BaseFilterEntity> params) {
    return repository.getArticles(params.value1, params.value2, params.value3.tag, params.value3.keywords);
  }
}
