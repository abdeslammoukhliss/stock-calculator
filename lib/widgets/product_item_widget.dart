import 'package:flutter/material.dart';

import '../entities/product.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  final Function onProductClick;

  ProductItemWidget({required this.product,required this.onProductClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onProductClick(product);
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.imageUrl,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: ${product.name}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Quantity: ${product.quantity}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Unit Price: ${product.unitPrice}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "User: ${product.user}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Total: ${(product.quantity * product.unitPrice).toString()}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}