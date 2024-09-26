import 'package:cached_network_image/cached_network_image.dart';
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
              CachedNetworkImage(
                imageUrl: product.imageUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 100,
                height: 100,
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
                    const SizedBox(height: 3),
                    Text(
                      "Quantity: ${product.quantity}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Unit Price: ${product.unitPrice}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "User: ${product.user}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 3),
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