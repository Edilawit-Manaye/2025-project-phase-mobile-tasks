import '../error/failures.dart';
import 'package:equatable/equatable.dart';

// A generic UseCase class with better typing
abstract class UseCase<Type, Params> {
  Future<(Failure?, Type)> call(Params params);
}

// A special class for use cases that don't require any parameters
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}