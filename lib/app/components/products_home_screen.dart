import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tutorials/app/views/homepage.dart';

import '../../database/db_helper.dart';
import '../../providers/cart_provider.dart';
import '../models/cart_model.dart';

class ProductsHomeScreen extends StatelessWidget {

  DBHelper dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 350,
          child: Padding(
                     padding: const EdgeInsets.only(top: 10,left: 10),
                     child: ListView.builder(
                      shrinkWrap: true,
                       scrollDirection: Axis.horizontal,
                       itemCount: productPrice.length,
                       itemBuilder: (context, index) {
                        
                         return Column(
                           children: [
                            
                             SizedBox(
                              width: 200,
                              height: 250,
                               child: Card(
                                color: Colors.yellow,
                                 child: 
                                     Padding(
                                       padding: const EdgeInsets.all(0),
                                       child: CachedNetworkImage(
                                        placeholder:(context,url) {
                                       

                                          return Container(height: 200,width: 200,color: Colors.grey.shade200,);
                                        },
                                        imageUrl: productImages[index],fit: BoxFit.cover,)),
                                     
                                     
                                   
                               ),
                             ),
                             Center(child: Text('₹ '+productPrice[index].toString(),style: TextStyle(fontSize: 24),)),
                                   ElevatedButton(onPressed: (){
                                     
                                          dbHelper.insert(
                                               Cart(
                                                id: index,
                                               
                                                productId: index.toString(),
                                                 productImage: productImages[index].toString(), 
                                                 quantity: 1, 
                                                 initialPrice: productPrice[index],
                                                  productPrice: productPrice[index]
                                                  )
                                          ).then((value){
                                            cart.addCounter();
                                            
                                            cart.addTotalPrice(double.parse(productPrice[index].toString()));
                                            
                                            print(' Product is added to cart');
                                            print(cart.totalPrice);
                                          }).onError((error, stackTrace) {
                                            print('error'+error.toString());
                                          });
                                        },  
                                         style: ElevatedButton.styleFrom(
                                           primary: const Color.fromARGB (255,73, 99, 121),),
                                        child: 
                                        (cart.added == false )?
                                        (
                                          
                                          Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:const [
                                            Icon(Icons.shopping_bag_outlined,color: Colors.white,),
                                            SizedBox(width: 5,),
                                            Text('Add To Bag',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                          ],
                                        ) ): Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:const [
                                            Icon(Icons.check,color: Colors.white,),
                                            SizedBox(width: 5,),
                                            Text('Added To Bag',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                            
                                          ],
                                        ) 
                                        )
                                       
                           ],
                         );
                         
                       }),
                   ),
        ),
        
      ],
    );
  }
}