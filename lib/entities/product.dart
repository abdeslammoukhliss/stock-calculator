import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  static int ID = 1;
  String? id;
  String name = "unkown";
  double unitPrice;
  int quantity;
  String imageUrl;
  String user;
  DateTime createdAt;

  Product(
      {this.id,
      this.name = "unkown",
      required this.unitPrice,
      this.quantity = 0,
      this.imageUrl =
          "https://static.vecteezy.com/system/resources/previews/007/451/786/original/an-outline-isometric-icon-of-unknown-product-vector.jpg",
      required this.user,
      required this.createdAt}) {
    if (this.id == null) {
      this.id = ID.toString();
      ID = ID + 1;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'unitPrice': unitPrice,
      'imageUrl': imageUrl,
      "quantity": quantity,
      'user': user,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory Product.fromJson(String id, Map<String, dynamic> json) {
    return Product(
      id: id,
      name: json['name'] ?? 'unkown',
      unitPrice: json['unitPrice'] ?? 0.0,
      imageUrl: json['imageUrl'] ??
          "https://static.vecteezy.com/system/resources/previews/007/451/786/original/an-outline-isometric-icon-of-unknown-product-vector.jpg",
      quantity: json['quantity'] ?? 0,
      user: json['user'],
      createdAt: json['createdAt'] ?? DateTime.now(),
    );
  }
  factory Product.fromSnapshot(QueryDocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic> ?? {};
    return Product(
        id: snapshot.id,
        name: data['name'] ?? 'unknown',
        unitPrice: (data['unitPrice'] ?? 0.0).toDouble(),
        imageUrl: data['imageUrl'] ??
            "https://static.vecteezy.com/system/resources/previews/007/451/786/original/an-outline-isometric-icon-of-unknown-product-vector.jpg",
        quantity: data['quantity'] ?? 0,
        user: data['user'] ?? '',
        createdAt: (data['createdAt'] as Timestamp).toDate());
  }
  List<String> toCsv() {
    return [
      id ?? "0",
      name,
      user,
      createdAt.toString(),
      unitPrice.toString(),
      quantity.toString(),
    ];
  }

  factory Product.fromCsv(List<dynamic> row) {
    return Product(
      id: row[0],
      name: row[1],
      user: row[2],
      createdAt: row[3],
      unitPrice: row[4],
      quantity: row[5],
    );
  }
}
