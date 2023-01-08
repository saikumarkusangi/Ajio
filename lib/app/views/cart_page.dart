import 'package:badges/badges.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tutorials/app/views/homepage.dart';
import 'package:provider_tutorials/app/views/homepage.dart';

import '../../database/db_helper.dart';
import '../../providers/cart_provider.dart';
import '../models/cart_model.dart';




class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart  = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black,size: 32),
        title: Text('Bag',style: TextStyle(color: Colors.black,fontSize: 22),),
        backgroundColor: Colors.white,
        elevation: 1,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
              future:cart.getData() ,
                builder: (context , AsyncSnapshot<List<Cart>> snapshot){
                if(snapshot.hasData){

                  if(snapshot.data!.isEmpty){
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Text('Your cart is empty ' ,style: Theme.of(context).textTheme.headline5),
                          SizedBox(height: 20,),
                          Text('Explore products and shop your\nfavourite items' , textAlign: TextAlign.center ,style: Theme.of(context).textTheme.subtitle2)

                        ],
                      ),
                    );
                  }else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image(
                                          height: 100,
                                          width: 100,
                                          image: NetworkImage(snapshot.data![index].productImage.toString()),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              

                                              SizedBox(height: 5,),
                                             
                                              
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    
                                                      
                                                    InkWell(
                                                      onTap: (){


                                                      },
                                                      child:  Container(
                                                        height: 35,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: Color.fromARGB(255, 231, 230, 230),
                                                            borderRadius: BorderRadius.circular(5)
                                                        ),
                                                        child:  Padding(
                                                          padding: const EdgeInsets.all(4.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                  onTap: (){

                                                                    int quantity =  snapshot.data![index].quantity! ;
                                                                    int price = snapshot.data![index].initialPrice!;
                                                                    quantity--;
                                                                    int? newPrice = price * quantity ;

                                                                    if(quantity > 0){
                                                                      dbHelper!.updateQuantity(
                                                                          Cart(
                                                                             
                                                                              id: snapshot.data![index].id!,
                                                                              productId: snapshot.data![index].id!.toString(),
                                                                              
                                                                              initialPrice: snapshot.data![index].initialPrice!,
                                                                              productPrice: newPrice,
                                                                              quantity: quantity,
                                                                              
                                                                              productImage: snapshot.data![index].productImage.toString())
                                                                      ).then((value){
                                                                        newPrice = 0 ;
                                                                        quantity = 0;
                                                                        cart.removeTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                      }).onError((error, stackTrace){
                                                                        print(error.toString());
                                                                      });
                                                                    }

                                                                  },
                                                                  child: Icon(Icons.remove , color: Colors.black87,)),
                                                              Text( snapshot.data![index].quantity.toString(), style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18)),
                                                              InkWell(
                                                                  onTap: (){
                                                                    int quantity =  snapshot.data![index].quantity! ;
                                                                    int price = snapshot.data![index].initialPrice!;
                                                                    quantity++;
                                                                    int? newPrice = price * quantity ;

                                                                    dbHelper!.updateQuantity(
                                                                        Cart(
                                                                            id: snapshot.data![index].id!,
                                                                            productId: snapshot.data![index].id!.toString(),
                                                                            
                                                                            initialPrice: snapshot.data![index].initialPrice!,
                                                                            productPrice: newPrice,
                                                                            quantity: quantity,
                                                                           
                                                                            productImage: snapshot.data![index].productImage.toString())
                                                                    ).then((value){
                                                                      newPrice = 0 ;
                                                                      quantity = 0;
                                                                      cart.addTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                    }).onError((error, stackTrace){
                                                                      print(error.toString());
                                                                    });
                                                                  },
                                                                  child: Icon(Icons.add , color: Colors.black87,)),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 20,),
                                                    InkWell(
                                                        onTap: (){
                                                          dbHelper!.delete(snapshot.data![index].id!);
                                                          cart.removeCounter();
                                                          cart.removeTotalPrice(double.parse(snapshot.data![index].productPrice.toString()));
                                                        },
                                                        child: 
                                                        Container(
                                                          height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children:const [
                                                           Icon(Icons.delete,color: Colors.white,),
                                                           Text('Remove',style: TextStyle(color: Colors.white),)
                                                        ],
                                                      ),
                                                        )
                                                        ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
              
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }

                }
              return Text('') ;
            }),
            Consumer<CartProvider>(builder: (context, value, child){
              return Visibility(
                visible: value.getTotalPrice().toStringAsFixed(2) == "0.00" ? false : true,
                child: Column(
                  children: [
                    Stack(
                     
                      children: 

                        [ Image.network('https://www.pngitem.com/pimgs/m/30-308623_torn-note-paper-png-ripped-paper-note-png.png',fit: BoxFit.fitHeight,height: 150,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 50,),
                              ReusableWidget(title: 'Sub Total', value: r'₹'+value.getTotalPrice().toStringAsFixed(2),),
                              ReusableWidget(title: 'Discout 5%', value: r'₹'+'20',),
                              ReusableWidget(title: 'Total', value: r'₹'+(value.getTotalPrice()-20).toStringAsFixed(2),)
                             ,
                             
                            ],
                        ),
                          ),
                      ],
                    ),
                    SizedBox(height: 50,),
                    Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('₹'+(value.getTotalPrice()-20).toStringAsFixed(2),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
                              ElevatedButton(
                                
                                onPressed: (){
                    
                              }, 
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(180, 50),
                                                   primary:  Colors.black),
                              child: Text('Proceed to Payment'))
                            ],
                           )
                  ],
                ),
              );
            })
          ],
        ),
      ) ,
    );
  }
}


class ReusableWidget extends StatelessWidget {
  final String title , value ;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title , style: Theme.of(context).textTheme.subtitle2,),
          Text(value.toString() , style: Theme.of(context).textTheme.subtitle2,)
        ],
      ),
    );
  }
}