import 'package:dartz/dartz.dart';
import 'package:supdup/core/error/failures.dart';
import 'package:supdup/features/domain/entities/api_entity.dart';

abstract class Repository {
  Future<Either<Failure, ApiEntity>> getData();
}