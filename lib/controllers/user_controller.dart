import 'package:flutter/cupertino.dart';
import 'package:stcok_calculator/services/prodcut_service.dart';

import '../entities/product.dart';

class UserController with ChangeNotifier{
  String _user = 'Guest';
  String get user => _user;
  ProductService productService;
  UserController({required this.productService});
  void setUser(String user){
    _user = user;
    notifyListeners();
  }
  Stream<List<Product>> getProductsStream() {
   return productService.getProductsStream();
  }

}