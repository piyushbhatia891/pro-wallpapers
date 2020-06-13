import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:prowallpapers/screens/categories_page/models/photos_model.dart';
import 'package:prowallpapers/screens/detail_page/index.dart';
import 'package:prowallpapers/shared/assets/constants.dart';
class SearchPage extends StatefulWidget{
  final String searchedString;
  SearchPage({this.searchedString});
  _SearchPageState createState()=>_SearchPageState();
}
class _SearchPageState extends State<SearchPage>{
  int numOfImagesToLoad=30;
  int pageCount;
  bool isLoading=false;
  List<PhotosModel> photos = new List();
  getSearchWallpaper(String searchQuery,int pageCount) async {
    await http.get(
        "https://api.pexels.com/v1/search?query=$searchQuery&per_page=${numOfImagesToLoad}&page=${pageCount}",
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

      setState(() {
        isLoading=false;
      });
    });
  }
  ScrollController _scrollController = new ScrollController();

  void initState(){
    pageCount=1;
    getSearchWallpaper(widget.searchedString,pageCount);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pageCount=pageCount+1;
        isLoading=true;
        getSearchWallpaper(widget.searchedString,pageCount);
      }
    });
    super.initState();
  }
  Widget build(BuildContext context){
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.searchedString),
        centerTitle: true,
      ),
      body:GridView.builder(

        controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
          ),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(4.0),
          itemCount: photos.length+1,
          itemBuilder:(context,int index) {
            if(index==photos.length) return Center(child:CircularProgressIndicator(backgroundColor: Colors.blue));
            else {
              return GridTile(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              DetailsPage(imgPath: photos[index].src
                                  .portrait)));
                    },
                    child:Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                                imageUrl: photos[index].src.portrait,
                                placeholder: (context, url) =>
                                    Container(
                                      color: Color(0xfff5f8fd),
                                    ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  );
            }
          }
          )

    );
  }
  Widget getContainer(PhotosModel model,bool isOpacity){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(imgPath:model.src.portrait)));
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