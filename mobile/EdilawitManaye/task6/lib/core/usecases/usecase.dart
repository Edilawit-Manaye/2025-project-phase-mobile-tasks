import '../error/failures.dart';

// A generic UseCase class
abstract class UseCase<Type, Params> {
  Future<(Failure?, Type)> call(Params params);
}

// A special class for use cases that don't require any parameters
class NoParams {}