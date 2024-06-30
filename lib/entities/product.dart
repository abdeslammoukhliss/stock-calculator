import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name="unkown";
  double unitPrice;
  int quantity;
  String imageUrl;
  String user;

  Product({required this.id, this.name="unkown", required this.unitPrice,this.quantity=0, required this.imageUrl, required this.user});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'unitPrice': unitPrice,
      'imageUrl': imageUrl,
      'user': user,
    };
  }

  factory Product.fromJson(String id, Map<String, dynamic> json) {
    return Product(
      id: id,
      name: json['name']??'unkown',
      unitPrice: json['unitPrice']??0.0,
      imageUrl: json['imageUrl']??"https://static.vecteezy.com/system/resources/previews/007/451/786/original/an-outline-isometric-icon-of-unknown-product-vector.jpg",
      quantity: json['quantity']??0,
      user: json['user'],
    );
  }
  factory Product.fromSnapshot(QueryDocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic> data = snapshot.data()  as Map<String, dynamic> ?? {};
    return Product(
      id: snapshot.id,
      name: data['name'] ?? 'unknown',
      unitPrice: (data['unitPrice'] ?? 0.0).toDouble(),
      imageUrl: data['imageUrl'] ?? "https://static.vecteezy.com/system/resources/previews/007/451/786/original/an-outline-isometric-icon-of-unknown-product-vector.jpg",
      quantity: data['quantity'] ?? 0,
      user: data['user'] ?? '',
    );
  }
}
