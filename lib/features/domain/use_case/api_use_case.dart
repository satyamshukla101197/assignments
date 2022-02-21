import 'package:dartz/dartz.dart';
import 'package:supdup/core/error/failures.dart';
import 'package:supdup/core/usecse/usecase.dart';
import 'package:supdup/features/domain/entities/api_entity.dart';
import 'package:supdup/features/domain/repositories/repository.dart';

class ApiUseCase
    extends UseCase<ApiEntity,NoParams>{
  final Repository _repository;

  ApiUseCase(this._repository);

  @override
  Future<Either<Failure, ApiEntity>> call(NoParams params) async{
    return await _repository.getData();
  }

}