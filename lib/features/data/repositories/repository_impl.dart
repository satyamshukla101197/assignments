import 'package:dartz/dartz.dart';
import 'package:supdup/core/error/exceptions.dart';
import 'package:supdup/core/error/failures.dart';
import 'package:supdup/core/network/network_info.dart';
import 'package:supdup/core/utils/constants.dart';
import 'package:supdup/features/data/datasource/local_datasource.dart';
import 'package:supdup/features/data/datasource/remote_datasource.dart';
import 'package:supdup/features/domain/entities/api_entity.dart';
import 'package:supdup/features/domain/repositories/repository.dart';

class RepositoryImpl extends Repository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});


  @override
  Future<Either<Failure, ApiEntity>> getData() async {
    if (await networkInfo.isConnected) {
      try {
        final apidata = await remoteDataSource.getData();
        return Right(ApiEntity(
            message: apidata.message!,
            status: apidata.status!


        ));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: Constants.ERROR_NO_INTERNET));
    }
  }
}
