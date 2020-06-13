import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:simple_permissions/simple_permissions.dart';
class DetailsPage extends StatefulWidget{
  final String imgPath;
  DetailsPage({@required this.imgPath});
  _DetailsPageState createState()=>_DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>{
  final GlobalKey<ScaffoldState> _scaffoldKey=new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:
                  CachedNetworkImage(
                imageUrl: widget.imgPath,
                placeholder: (context, url) => Container(
                  color: Color(0xfff5f8fd),
                ),
                fit: BoxFit.cover,
              ),

          ),
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InkWell(
                onTap: () {
                    _save();
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xff1C1B1B).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.white24, width: 2),
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0x36FFFFFF),
                                  Color(0x0FFFFFFF)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Make It A Wallpaper",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Text(
                              "Image will also be saved in gallery",
                              style: TextStyle(
                                  fontSize: 8, color: Colors.white70),
                            ),
                          ],
                        )),
                  ],
                )),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ))
        ],
      ),
    );
  }

  _save() async {

    PermissionStatus status=await _askPermission();
    if(status==PermissionStatus.denied || status==PermissionStatus.restricted || status==PermissionStatus.deniedNeverAsk) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              title: Text("Permission denied"),
              content: Text("Permission issue"),
              actions: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text("Ok"),
                  ),

                )
              ],
            );
          }
      );
    }else if(status==PermissionStatus.authorized) {
      var response = await Dio().get(widget.imgPath,
          options: Options(responseType: ResponseType.bytes));
      final result =
      await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
      //Navigator.pop(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("The image is saved."),

      ));
    }
  }

  Future<PermissionStatus> _askPermission() async {
      PermissionStatus status=await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
      return status;
  }
}