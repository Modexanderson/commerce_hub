import 'package:commerce_hub/models/Product.dart';
import 'package:commerce_hub/screens/edit_product/provider_models/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';

class EditProductScreen extends StatelessWidget {
  final Product? productToEdit;

  const EditProductScreen({Key? key, required this.productToEdit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductDetails(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: Navigator.of(context).pop,
          ),
        ),
        body: Body(
          productToEdit: productToEdit,
        ),
      ),
    );
  }
}
