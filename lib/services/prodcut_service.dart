import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/product.dart';

class ProductService {
  FirebaseFirestore firestoreInstance;

  ProductService({required this.firestoreInstance});

  Future<void> addProduct(Product product) async {
    try {
      await firestoreInstance.collection('products').add(product.toJson());
      print('Product added successfully!');
    } catch (e) {
      print('Error adding product: $e');
      // Optionally, handle or throw the error further
    }
  }

  Stream<List<Product>> getProductsStream() {
    return firestoreInstance
        .collection('products')
        .orderBy('createdAt', descending: true) // Order by createdAt descending
        .snapshots()
        .map((QuerySnapshot query) {
      return query.docs.map((doc) {
        return Product.fromSnapshot(doc);
      }).toList();
    });
  }
  Future<void> deleteProduct(String productId) async {
    try {
      await firestoreInstance.collection('products').doc(productId).delete();
      print('Product deleted successfully!');
    } catch (e) {
      print('Error deleting product: $e');
      // Optionally, handle or throw the error further
    }
  }
  Future<void> updateProduct(String productId, {String? name, double? unitPrice, String? user, String? imageUrl}) async {
    try {
      Map<String, dynamic> updatedData = {};
      if (name != null) updatedData['name'] = name;
      if (unitPrice != null) updatedData['unitPrice'] = unitPrice;
      if (user != null) updatedData['user'] = user;
      if (imageUrl != null) updatedData['imageUrl'] = imageUrl;

      await firestoreInstance.collection('products').doc(productId).update(updatedData);
      print('Product updated successfully!');
    } catch (e) {
      print('Error updating product: $e');
      // Optionally, handle or throw the error further
    }
  }
}

