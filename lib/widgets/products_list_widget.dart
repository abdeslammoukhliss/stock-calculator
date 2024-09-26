import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stcok_calculator/controllers/user_controller.dart';
import 'package:stcok_calculator/widgets/product_item_widget.dart';

import '../entities/product.dart';

class ProductListWidget extends StatefulWidget {
  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
   List<Product> products = [];

 @override
  void initState() {
    context.read<UserController>().getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    products = context.watch<UserController>().displayedProducts;

          return products.isEmpty?Center(child: Text('No Products Found'),):
            ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Container(
                child: ProductItemWidget(
                    product: products[index],
                    onProductClick: (product) {
                      print('Product Clicked: ${product.name}');
                    }),
              );
            },
          );

  }
}
