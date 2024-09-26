import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import '../entities/product.dart';

class ProductServiceCSV {
  List<Product> products = [];
  String csvFilePath = '';

  ProductService() {
    _initialize();
  }

  Future<void> _initialize() async {
    final directory = await getApplicationDocumentsDirectory();
    csvFilePath = '${directory.path}/products.csv';
  }

  Future<List<Product>> getProducts() async {
    try {
      final file = File(csvFilePath);

      if (await file.exists()) {
        final input = file.openRead();
        final fields = await input
            .transform(utf8.decoder)
            .transform(CsvToListConverter())
            .toList();

        products = fields.skip(1).map((row) {
          return Product(
            id: row[0],
            name: row[1],

            user: row[2],
            createdAt: DateTime.parse(row[3]),
            unitPrice: double.tryParse(row[4].toString()) ?? 0.0,
            quantity: int.tryParse(row[5].toString()) ?? 0,
          );
        }).toList();
      } else {
        // If the file does not exist, create it with headers
        await file.writeAsString(
          'id,name,unitPrice,user,createdAt,quantity\n',
        );
      }
    } catch (e) {
      print('Error loading products: $e');
    }
    return products;
  }


  Future<void> addProduct(Product product) async {
    try {
      products.add(product);

      final file = File(csvFilePath);
      final sink = file.openWrite(mode: FileMode.append);
      sink.write('${product.id},${product.name},${product.user},${product.createdAt.toIso8601String()},${product.unitPrice},${product.quantity}\n');
      await sink.close();

      print('Product added successfully!');
    } catch (e) {
      print('Error adding product: $e');
    }
  }



  Future<void> deleteProduct(String productId) async {
    try {
      products.removeWhere((product) => product.id == productId);
      await _rewriteCSV();
      print('Product deleted successfully!');
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  Future<void> updateProduct(String productId, {String? name, double? unitPrice, String? user, String? imageUrl}) async {
    try {
      final index = products.indexWhere((product) => product.id == productId);
      if (index != -1) {
        if (name != null) products[index].name = name;
        if (unitPrice != null) products[index].unitPrice = unitPrice;
        if (user != null) products[index].user = user;
        if (imageUrl != null) products[index].imageUrl = imageUrl;

        await _rewriteCSV();
        print('Product updated successfully!');
      }
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<void> _rewriteCSV() async {
    try {
      final file = File(csvFilePath);
      List<List<dynamic>> rows = [
        [ 'id','name','user','createdAt','unitPrice','quantity'],
      ];

      products.forEach((product) {
        rows.add([
          product.id,
          product.name,
          product.unitPrice,
          product.user,
          product.imageUrl,
          product.createdAt.toIso8601String(),
        ]);
      });

      String csv = const ListToCsvConverter().convert(rows);
      await file.writeAsString(csv);
      print('CSV file rewritten successfully!');
    } catch (e) {
      print('Error rewriting CSV file: $e');
    }
  }
}
