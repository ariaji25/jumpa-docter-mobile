import 'package:jd_mobile/domain/repositories/articles/articles_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class GetTags extends NoParamUseCase {
  final ArticleRepository repository;
  GetTags(this.repository);
  
  @override
  Future call() => repository.getTags();
}