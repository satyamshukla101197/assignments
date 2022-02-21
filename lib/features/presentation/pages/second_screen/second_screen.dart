import 'package:flutter/material.dart';
import 'package:supdup/core/utils/constants.dart';
import 'package:supdup/features/presentation/pages/argument/argument.dart';
class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}
class _SecondScreenState extends State<SecondScreen> {
  Argument? argument;
  @override
  Widget build(BuildContext context) {
    argument =ModalRoute.of(context)!.settings.arguments as Argument;
    return SafeArea(
      child: Scaffold(
        body: _getBody(),
      ),
    );
  }

 Widget _getBody() {
    return Container(
      child: Column(
        children: <Widget>[
          argument==null?Text("No Image Found"): Image.network(argument!.message,fit: BoxFit.fill,)
        ],
      ),
    );
 }
}
