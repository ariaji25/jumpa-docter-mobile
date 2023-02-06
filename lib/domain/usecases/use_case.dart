abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class NoParamUseCase<Type> {
  Future<Type> call();
}
