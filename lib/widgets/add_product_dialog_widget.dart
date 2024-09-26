import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controllers/user_controller.dart';

class AddProductDialog extends StatefulWidget {
  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();


  // Function to handle image selection from camera or gallery


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Add Product'),
      content: Container(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Unit Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity '),
                keyboardType: TextInputType.numberWithOptions(decimal: false),
              ),
              SizedBox(height: 10),
              Center(
                child:  TextButton.icon(
                  onPressed: () => context.read<UserController>().takePicture(ImageSource.camera,_nameController.text),
                  icon: Icon(Icons.camera_alt),
                  label: Text('Take Picture'),
                )

              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Add'),
          onPressed: () {
            context.read<UserController>().addProduct(context: context,
              name: _nameController.text,
              unitPrice: double.parse(_priceController.text),
              quantity: int.parse(_quantityController.text),

            );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
