import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prowallpapers/screens/categories_page/models/category_model.dart';
import 'package:prowallpapers/screens/categories_page/widgets/trending_widgets.dart';
import 'package:prowallpapers/screens/detail_page/index.dart';
import 'package:prowallpapers/screens/search_page/search_page.dart';
import 'package:prowallpapers/shared/assets/text_style.dart';
class CategoriesPage extends StatefulWidget{
  _CategoriesPageState createState()=>_CategoriesPageState();
}
class _CategoriesPageState extends State<CategoriesPage>{

List<CategoryModel> categoryModel=[
  new CategoryModel("Sceneries", 'assets/images/cat_scenery.jpg'),
  new CategoryModel("Shopping", 'assets/images/cat_shopping.jpg'),
  new CategoryModel("Landscapes", 'assets/images/cat_landscape.jpg'),
  new CategoryModel("Hills", 'assets/images/cat_hills.jpg'),
  new CategoryModel("Nature", 'assets/images/cat_nature.jpg'),
  new CategoryModel("Religious", 'assets/images/cat_religious.jpg'),
];

void initState(){
  super.initState();
  _scrollController.addListener(() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print(_scrollController.position.pixels);
    }
    else
      print("not done");
  });
}
ScrollController _scrollController = new ScrollController();
  Widget build(BuildContext context){
    return buildCategoriesWidget();
  }

  Widget buildCategoriesWidget(){
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallpapers"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                padding: const EdgeInsets.all(0.0),
                height: MediaQuery.of(context).size.height*0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/cat_scenery.jpg'),
                    fit: BoxFit.fill
                  )
                ),
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoriesPage()));
              },
              title: Text('Home'),
              trailing:Icon(Icons.arrow_forward_ios,size: 12.0) ,
            ),
            ListTile(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoriesPage()));
              },
              title: Text('About us'),
              trailing:Icon(Icons.arrow_forward_ios,size: 12.0) ,
            )

          ],
        ),
      ),
      body: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(15.0),
                child: Text(
                  "Categories",
                  textAlign: TextAlign.left,
                  style: TextStyles.largeSizeBlackColorBoldTextStyle,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(15.0),
                height: MediaQuery.of(context).size.height*0.10,
                child: ListView.builder(
                  itemCount: categoryModel.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,int index){
                    CategoryModel model=categoryModel[index];
                    return getContainer(model);
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(15.0),
                child: Text(
                  "Wallpapers",
                  textAlign: TextAlign.left,
                  style: TextStyles.largeSizeBlackColorBoldTextStyle,
                ),
              ),
            ),
            TrendingWidgetsPage()
          ],
        ),

    );
  }

  Widget getContainer(CategoryModel model){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage(searchedString: model.title)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        width: MediaQuery.of(context).size.width*0.35,
        child: Center(
          child: Text(model.title,style: TextStyles.largeSizeWhiteColorBoldTextStyle),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(model.imageUrl),
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),

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