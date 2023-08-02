import 'package:commerce_hub/screens/product_details/components/fab_body.dart';
import 'package:commerce_hub/screens/product_details/provider_models/ProductActions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  final String? phone;

  const ProductDetailsScreen(
      {Key? key, required this.productId, required this.phone})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductActions(),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: Navigator.of(context).pop,
          ),
        ),
        body: Body(
          productId: productId,
        ),
        floatingActionButton: FabBody(productId: productId),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
