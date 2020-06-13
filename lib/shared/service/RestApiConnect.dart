import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prowallpapers/screens/categories_page/models/photos_model.dart';
import 'package:prowallpapers/shared/assets/constants.dart';
class RestApiConnect{
  getTrendingImages(int numOfImages)async{
    List<PhotosModel> photos = new List();
    await http.get(
        "https://api.pexels.com/v1/curated?per_page=$numOfImages&page=1",
        headers: {"Authorization": Constants.PEXELS_API_KEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });
      return photos;
    });
  }

  getSearchWallpaper(String searchQuery) async {
    List<PhotosModel> photos = new List();
    await http.get(
        "https://api.pexels.com/v1/search?query=$searchQuery&per_page=30&page=1",
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
    });
  }
}