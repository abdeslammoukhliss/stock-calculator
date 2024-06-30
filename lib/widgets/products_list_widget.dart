import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stcok_calculator/controllers/user_controller.dart';
import 'package:stcok_calculator/widgets/product_item_widget.dart';

import '../entities/product.dart';

class ProductListWidget extends StatelessWidget {
   List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: context.read<UserController>().getProductsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No products available'));
        } else {
          products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductItemWidget(
                  product: products[index],
                  onProductClick: (product) {
                    print('Product Clicked: ${product.name}');
                  });
            },
          );
        }

      },


    );
    return Container(

    );
  }
}
