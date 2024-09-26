import 'dart:async';
import 'dart:collection';

import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stcok_calculator/services/csv_service.dart';
import 'package:stcok_calculator/services/path_service.dart';
import 'package:stcok_calculator/services/prodcut_service.dart';
import 'package:stcok_calculator/services/product_service_csv.dart';

import '../entities/product.dart';
import '../services/fire_storage_service.dart';
import '../services/permission_service.dart';

class UserController with ChangeNotifier{

  PermissionStatus _cameraPermissiontatus = PermissionStatus.denied;
  PermissionStatus _storagePermissionStatus = PermissionStatus.denied;

  File? imageFile;

  String _user = 'Guest';
  String get user => _user;
  List<Product> products = [];
  List<Product> displayedProducts = [];

  ProductServiceCSV productService;
  HashSet <String> users = HashSet();
  HashSet<String> selectedUsers = HashSet();
  FireStorageService fireStorageService;
  CSVService csvService;
  PermissionService permissionService = PermissionService();
  UserController({required this.productService,required this.fireStorageService,required this.csvService});


  void setUser(String user){
    _user = user;
    users.add(user);
    selectedUsers.add(user);
    notifyListeners();
  }
  void setProducts(List<Product> products){
    this.products=products;
    notifyListeners();
  }
  void setDisplayedProducts(){
    displayedProducts.clear();
    products.forEach((e)  {
      if(selectedUsers.contains(e.user))
         displayedProducts.add(e);
    });
    notifyListeners();
  }
  void setUsersList(List<String> users){
    this.users.clear();
    users.forEach((element) {
      this.users.add(element);
    });
    users.add(user);
    Future.microtask(() => notifyListeners());
  }
  void setSelectedList(List<String> users){
    this.selectedUsers.clear();
    users.forEach((element) {
      this.selectedUsers.add(element);
    });
    setDisplayedProducts();
    Future.microtask(() => notifyListeners());
  }



  Future<void> getProducts() async{
    products= await productService.getProducts();
    displayedProducts=products;
    notifyListeners();
  }
  checkPermission() async {
    _cameraPermissiontatus = await permissionService.requestCameraPermission();
    notifyListeners();
  }
  Future<void> requestPermission() async {
    _cameraPermissiontatus = await permissionService.requestCameraPermission();
    notifyListeners();
  }
  Future<void> takePicture(ImageSource source,String name) async {
    await checkPermission();
    if(_cameraPermissiontatus.isDenied){
      await requestPermission();
    }else if(_cameraPermissiontatus.isPermanentlyDenied){
      openAppSettings();
    }
    if(_cameraPermissiontatus.isGranted){
      final pickedFile = await ImagePicker().pickImage(source: source);
      imageFile = File(pickedFile!.path);

    }
  }

  void addProduct({required String name, required double unitPrice, required int quantity,required BuildContext context})async {
    String imageUrl="https://static.vecteezy.com/system/resources/previews/007/451/786/original/an-outline-isometric-icon-of-unknown-product-vector.jpg";
    await productService.addProduct(Product(name: name, unitPrice: unitPrice, quantity: quantity, user: _user, imageUrl: imageUrl, createdAt: DateTime.now()));
    getProducts();
    this.showSnackBar(context,"Product added successfully", true);

  }

  void downloadFile(BuildContext context) async {

      await getStoragePermission();
      if(_storagePermissionStatus.isGranted) {
        await csvService.getFilePath().then((String path) async {
          print("File path: $path");
          File file = File(path);
          await PathService.moveFileToDownloadDirectory(file.path);
          showSnackBar(context, "File downloaded successfully", true);
        });
      }else if(_storagePermissionStatus.isPermanentlyDenied) {
        openAppSettings();
      }else{
        showSnackBar(context, "Permission denied", false);
      }
    }
void showSnackBar(BuildContext context, String message,bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
  getStoragePermission() async {
    _storagePermissionStatus= await permissionService.requestStoragePermission();
  }
  Future deleteFile()async{
    String filePath=await csvService.getFilePath();
   await PathService .deleteFile(filePath);
  }

}