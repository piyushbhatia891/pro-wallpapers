import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prowallpapers/screens/categories_page/index.dart';
import 'package:prowallpapers/shared/assets/text_style.dart';
class HomePage extends StatefulWidget {
  final String title;
  HomePage({@required this.title});
  _HomePageState createState()=>_HomePageState();
}
class _HomePageState extends State<HomePage>{

  @override
  void initState(){
    super.initState();
    Timer(
        Duration(seconds: 3),
            (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesPage()));
        });
  }
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
            CircularProgressIndicator(
              valueColor:new AlwaysStoppedAnimation<Color>(Colors.grey),
            )
          ],
        ),
      )
    );
  }

}