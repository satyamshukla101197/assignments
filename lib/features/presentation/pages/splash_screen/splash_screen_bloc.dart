import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supdup/core/error/failures.dart';
import 'package:supdup/core/usecse/usecase.dart';
import 'package:supdup/core/utils/constants.dart';
import 'package:supdup/features/domain/entities/api_entity.dart';
import 'package:supdup/features/domain/use_case/api_use_case.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final ApiUseCase _apiUseCase;
  SplashScreenBloc({
    required  final ApiUseCase apiUseCase
}) :assert(apiUseCase != null),
  _apiUseCase=apiUseCase,
        super(SplashScreenInitial());

  @override
  Stream<SplashScreenState> mapEventToState(
    SplashScreenEvent event,
  ) async* {
    if (event is SplashScreenEvent) {
      yield ApiLoadingState();
      final data = await _apiUseCase.call(NoParams());
      yield* data.fold((failure) async* {
        if (failure is CacheFailure) {
          yield ApiScreenErrorState(message: failure.message);
        } else if (failure is ServerFailure) {
          yield ApiScreenErrorState(message: failure.message);
        } else {
          yield ApiScreenErrorState(message: Constants.ERROR_UNKNOWN);
        }
      }, (loadedDataEntity) async* {
        print("ffffffffffffff");
        yield ApiScreenLoadedState(apiEntity: loadedDataEntity);
      });
    }
  }
}
