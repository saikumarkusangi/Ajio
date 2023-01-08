import 'package:provider_tutorials/app/views/homepage.dart';

class Cart {
  late final int? id;
  final String? productId;
  final String? productImage;
  final int? quantity;
  final int? initialPrice;
  final int? productPrice;
 
  Cart({
    required this.id,
    
   required this.productId,
    required this.productImage,
    required  this.quantity,
     required  this.initialPrice, 
     required  this.productPrice
});

Cart.fromMap(Map<dynamic,dynamic> res):
id = res['id'],
productId = res['productId'],
initialPrice = res['initialPrice'],
quantity = res['quantity'],

productImage = res['productImage'],
productPrice = res['productPrice'];
Map<String,Object?> toMap(){
  return {
    'id':id,
    
     "productId" : productId,
    "productImage":productImage,
    "quantity":quantity,
     "initialPrice":initialPrice, 
     "productPrice":productPrice,
     
  };
}

}