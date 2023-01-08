import 'package:flutter/material.dart';
import 'package:provider_tutorials/database/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();
  int _counter =  0;
  int get counter => _counter;
  bool added = false;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getData() async{
    _cart = db.getCartList();
    return _cart;
  }
  
  void _setPrefItems() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_items', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

   void _getPrefItems() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_items') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _counter ++;
    added = true;
    _setPrefItems();
    
    notifyListeners();
  }
  
  void removeCounter() {
    _counter --;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }


  double addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItems();
    notifyListeners();
    return _totalPrice;
  }

  void removeTotalPrice(double productPrice) {
   _totalPrice = _totalPrice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }
}
