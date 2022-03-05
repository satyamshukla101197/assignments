import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supdup/core/config/localization.dart';
import 'package:supdup/core/config/navigation.dart';
import 'package:supdup/core/utils/constants.dart';
import 'package:supdup/core/utils/custom_extension.dart';
import 'package:supdup/core/utils/routes.dart';
import 'package:supdup/features/domain/entities/api_entity.dart';

import 'package:supdup/features/presentation/pages/splash_screen/splash_screen_bloc.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ApiEntity? apiEntity1;
  ApiEntity? apiEntity2;
  ApiEntity? apiEntity3;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColors.white,
        title: Text("App",style: TextStyle(color: Colors.black),),
      ),
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
            if (state.apiEntity1 != null) {
              apiEntity1=state.apiEntity1;
            }else if(state.apiEntity2 !=null){
              apiEntity2=state.apiEntity2;
            }else if(state.apiEntity3 !=null){
              apiEntity3=state.apiEntity3;
            }
          }
        },
        builder: (context, state) {
          if (state is SplashScreenInitial) {
            BlocProvider.of<SplashScreenBloc>(context)
                .add(apiScreenEventOne());
            BlocProvider.of<SplashScreenBloc>(context)
                .add(apiScreenEventTwo());
            BlocProvider.of<SplashScreenBloc>(context)
                .add(apiScreenEventThree());
          }
          return _getBody();
        },
      ),
    ));
  }

  Widget _getBody() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              apiEntity1==null?Container(): _getRow(image: apiEntity1!.message,),
              apiEntity2==null?Container(): _getRow(image: apiEntity2!.message,),
              apiEntity3==null?Container(): _getRow(image: apiEntity3!.message,),
              apiEntity1==null?Container(): _getRow(image: apiEntity1!.message,),
              apiEntity2==null?Container(): _getRow(image: apiEntity2!.message,),
              apiEntity3==null?Container(): _getRow(image: apiEntity3!.message,),
              apiEntity1==null?Container(): _getRow(image: apiEntity1!.message,),
              apiEntity2==null?Container(): _getRow(image: apiEntity2!.message,),
              apiEntity3==null?Container(): _getRow(image: apiEntity3!.message,),
              apiEntity1==null?Container(): _getRow(image: apiEntity1!.message,),
              apiEntity2==null?Container(): _getRow(image: apiEntity2!.message,),
              apiEntity3==null?Container(): _getRow(image: apiEntity3!.message,),
            ],
          )
      ),
    );
  }

  _getRow({required String image}) {
    return Container(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context,int index){
          return Padding(padding: EdgeInsets.only(left: 10.0));
        },
        itemCount: 30,
        itemBuilder: (BuildContext context,int index){
          return Container(
              height: 50,
              width: 50,
              child: Column(
                children: <Widget>[
                  Image.network(image,fit: BoxFit.fill,),
                ],
              )
          );
        },
      ),
    );
  }

}
