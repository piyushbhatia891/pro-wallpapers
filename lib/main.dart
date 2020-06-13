import 'package:flutter/material.dart';
import 'package:prowallpapers/screens/home_page.dart';
import 'package:prowallpapers/shared/assets/constants.dart';
import 'package:prowallpapers/shared/assets/text_style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_TITLE,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //buttonColor: Colors.white,
        accentColor: Colors.white,
        //primarySwatch: Colors.blue,
        primaryIconTheme: IconThemeData(
          color: Colors.black,
          size: 12.0
        ),
        fontFamily: 'Montserrat',
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 5.0,
          textTheme: TextTheme(
            title: TextStyles.largeSizeBlackColorBoldTextStyle
          )
        )
      ),
      home: HomePage(title: Constants.APP_TITLE),
    );
  }
}