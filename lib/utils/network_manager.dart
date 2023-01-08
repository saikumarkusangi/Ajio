import 'package:dio/dio.dart';
import 'package:provider_tutorials/app/models/products_model.dart';

class NetworkManager{
    
  late Dio _dio;

  String baseUrl = "";

  NetworkManager(){
    _dio = Dio();
  }
  
  Future<ProductsModel> getAll() async{
    var response = await Dio().get(
    "https://reqres.in/api/users",
    options: Options(
    headers: {
    "Content-Type": "application/json",
    },
    ),
    );
    Map obj = response.data;
  }

}