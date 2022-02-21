import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supdup/core/config/localization.dart';
import 'package:supdup/core/config/navigation.dart';
import 'package:supdup/core/utils/constants.dart';
import 'package:supdup/core/utils/custom_extension.dart';
import 'package:supdup/core/utils/routes.dart';
import 'package:supdup/features/domain/entities/api_entity.dart';
import 'package:supdup/features/presentation/pages/argument/argument.dart';
import 'package:supdup/features/presentation/pages/splash_screen/splash_screen_bloc.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ApiEntity? apiEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashScreenBloc, SplashScreenState>(
        listener: (context, state) {
          if (state is ApiScreenErrorState) {
            widget.showErrorToast(
                context: context, message: state.message ?? "");
            //Kill Loader
            Navigation.back(context);
          } else if (state is ApiLoadingState) {

            widget.showProgressDialog(context);
          } else if (state is ApiScreenLoadedState) {
            //Kill Loader
            Navigation.back(context);
            if (state.apiEntity != null) {
              apiEntity=state.apiEntity;
              Navigation.intentWithData(
                  context,
                  AppRoutes.second_screen,
                  Argument(status: apiEntity!.status, message: apiEntity!.message)
              );
            }
          }
        },
        builder: (context, state) {
          if (state is SplashScreenInitial) {
            // BlocProvider.of<SplashScreenBloc>(context)
            //     .add(apiScreenEvent());
          }
          return  Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: AppColors.white,
            child: Center(
                child: GestureDetector(
                  onTap: (){
                    BlocProvider.of<SplashScreenBloc>(context)
                        .add(apiScreenEvent());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.green
                    ),
                    padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 8.0,bottom: 8.0),
                    child: Text(
                      MyLocalizations.of(context).getString("fatch"),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
            ),
          );
        },
      ),
    );
  }
}
