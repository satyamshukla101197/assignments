part of 'splash_screen_bloc.dart';

abstract class SplashScreenState extends Equatable {
  const SplashScreenState();
}

class SplashScreenInitial extends SplashScreenState {
  @override
  List<Object> get props => [];
}
class ApiLoadingState extends SplashScreenState {
  @override
  List<Object> get props => [];
}
class ApiScreenErrorState extends SplashScreenState {
  final String message;

  ApiScreenErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ApiScreenLoadedState extends SplashScreenState {
  final ApiEntity? apiEntity;
 ApiScreenLoadedState({ this.apiEntity,});

  @override
  List<Object> get props => [apiEntity!,];
}