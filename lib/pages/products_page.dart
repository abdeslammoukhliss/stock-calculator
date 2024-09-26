import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stcok_calculator/widgets/add_product_dialog_widget.dart';
import 'package:stcok_calculator/widgets/filter_widget.dart';
import 'package:stcok_calculator/widgets/products_list_widget.dart';

import '../controllers/user_controller.dart';

class ProductsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              context.read<UserController>().downloadFile(context);
            }),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<UserController>().deleteFile();
            }
            ,
          ),
        ]

        ,
      ),
      body: Column(
        children: [
          Container(child: FilterWidget(title: "title", onFilterSelected: (filter) {}),height: 150,),
          Expanded(child: ProductListWidget()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddProductDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      )
    );
  }
}