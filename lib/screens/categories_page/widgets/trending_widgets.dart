import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prowallpapers/screens/categories_page/models/photos_model.dart';
import 'package:prowallpapers/screens/detail_page/index.dart';
import 'package:prowallpapers/shared/assets/constants.dart';
class TrendingWidgetsPage extends StatefulWidget{
  double pixel,scrollExtent;
  TrendingWidgetsPage({this.pixel,this.scrollExtent});
  _TrendingWidgetsPageState createState()=>_TrendingWidgetsPageState();
}
class _TrendingWidgetsPageState extends State<TrendingWidgetsPage>{
  int numOfImagesToLoad=30;
  List<PhotosModel> photos = new List();
  getTrendingImages()async{
    await http.get(
        "https://api.pexels.com/v1/curated?per_page=$numOfImagesToLoad&page=1",
        headers: {"Authorization": Constants.PEXELS_API_KEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }
  ScrollController _scrollController = new ScrollController();

  void initState(){
    super.initState();
    getTrendingImages();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        numOfImagesToLoad = numOfImagesToLoad + 30;
        getTrendingImages();
      }
    });
  }
  Widget build(BuildContext context){
    return  SliverPadding(
      padding: const EdgeInsets.all(10.0),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        mainAxisSpacing: 15,
        crossAxisSpacing: 5,
        children:
          photos.map((PhotosModel model){
            return getContainer(model, false);
          }).toList()

      ),
    );
  }
  Widget getContainer(PhotosModel model,bool isOpacity){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(imgPath: model.src.portrait)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        width: MediaQuery.of(context).size.width*0.35,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(model.src.portrait),
              fit: BoxFit.fill,

            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 6.0,
              ),
            ]
        ),
      ),
    );
  }
}