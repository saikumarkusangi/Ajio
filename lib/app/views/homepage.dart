import 'package:badges/badges.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:provider_tutorials/app/models/cart_model.dart';
import 'package:provider_tutorials/app/views/cart_page.dart';
import 'package:provider_tutorials/database/db_helper.dart';
import 'package:provider_tutorials/providers/cart_provider.dart';

import '../components/products_home_screen.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
List<int> productPrice = [
   400,560,880,1250,960,660
];
List<String> productImages = [
 'https://images.bewakoof.com/t640/men-s-striped-stylish-half-sleeve-casual-shirt-351539-1656167635-1.jpg',
 'https://imagescdn.peterengland.com/img/app/product/4/493949-3704224.jpg?auto=format&w=494.40000000000003',
 'https://assets.myntassets.com/dpr_1.5,q_60,w_400,c_limit,fl_progressive/h_373,q_80,w_280/v1/assets/images/16604622/2022/3/16/703916df-0534-4ab2-9853-1a584c63f7161647421339391-U-S-Polo-Assn-Denim-Co-Men-Khaki-Solid-Casual-Shirt-32916474-1.jpg',
 'https://sslimages.shoppersstop.com/sys-master/images/h8f/h8d/28382909300766/A22SFQSPPQ59944_NAVY.jpg_230Wx334H',
 'https://assets.myntassets.com/dpr_1.5,q_60,w_400,c_limit,fl_progressive/assets/images/1376577/2022/6/3/ea10ab6c-883e-437a-8780-ed87484393f81654235830793-Roadster-Men-Black--Grey-Checked-Casual-Sustainable-Shirt-42-1.jpg',
 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi6UMEqO12tWqGu2WfoX30yv_mnj7MwXFsWw&usqp=CAU'
];
class MyHomePage extends StatelessWidget {
 
  DBHelper dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
  final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        leading: SizedBox(child: Image.network('https://cdn-icons-png.flaticon.com/512/6995/6995971.png',scale: 15,)),
        centerTitle: true,
        title:SizedBox(
          height: 25,
          child: Image.network('https://i.ibb.co/Jm7rQwr/download.png')),
          actions: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>CartPage()));
              },
              child: Padding(
                 padding: EdgeInsets.only(right: 5),
                child: Center(
                  child: Badge(
                    toAnimate: true,
                    
                    animationType: BadgeAnimationType.fade,
                    badgeContent: Consumer<CartProvider>(
                      builder: (context,value,child){
                        return Text(value.counter.toString(),style: TextStyle(color: Colors.white,),);
                      },
                      ),
                    badgeColor: Colors.redAccent.withOpacity(0.9),
                    animationDuration: Duration(milliseconds: 300),
                   child: Icon(Icons.shopping_bag_outlined,color: Colors.black,size: 32,),
                  ),
                ),
              ),
            ),
             
             SizedBox(width: 10,)
          ],
      ),
     body: SafeArea(child: 
     SingleChildScrollView(
       child: Container(
      
        color: Colors.white,
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Card(
               elevation: 1,
                 color: Colors.grey.shade200,
                 child: ListTile(
                   leading: Image.network('https://cdn-icons-png.flaticon.com/512/2801/2801881.png',scale: 20,color: Colors.black54,),
                 title:Text('Search by Product,Brand & more....',style: TextStyle(fontSize: 18,color: Colors.black54),overflow: TextOverflow.ellipsis,)
                 )
                 ),
               ),
             BannerCarousel(
                 
                 banners: BannerImages.listBanners,
                 customizedIndicators: IndicatorModel.animation(
                     width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
                 height: MediaQuery.of(context).size.height/3,
                 activeColor: Color.fromARGB (255,73, 99, 121),
                 disableColor: Colors.white,
                 animation: true,
                 borderRadius: 10,
                 onTap: (id) => print(id),
                 width: MediaQuery.of(context).size.width,
                 indicatorBottom: false,
               ),
             Padding(
                             padding: const EdgeInsets.only(left:10.0,top: 20),
                             child: Text("Men's Shirt's",style: TextStyle(fontSize: 28),),
                           ),
             ProductsHomeScreen()
           ],
         ),
       ),
     )),
    );
  }
}
class BannerImages {
  static const String banner1 =
      "https://assets.ajio.com/medias/sys_master/images/images/hb2/h78/16750141276190/02052020-M-Pantaloons-topbanner-hottesttrends.jpg";
  static const String banner2 =
      "http://lh3.googleusercontent.com/B90GJVxEmuhLU-It_ZpQK4wlCU5O3uOYf3ipr93ZW0mNaJ0UnX1pqaSvXqFjI8hRkSd5lSGwAYGa9Yjz0z_EpU3zFfY=s750";
  static const String banner3 = "https://pbs.twimg.com/media/E-GWZxVWEAArm2o.jpg";
  static const String banner4 =
      "https://assets.ajio.com/medias/sys_master/images/images/h20/hdb/63666038702110/M-UHP-topbanner-1024x672-NowEnds20thNov.jpg";

  static List<BannerModel> listBanners = [
    BannerModel(imagePath: banner1, id: "1"),
    BannerModel(imagePath: banner2, id: "2"),
    BannerModel(imagePath: banner3, id: "3"),
    BannerModel(imagePath: banner4, id: "4"),
  ];
}