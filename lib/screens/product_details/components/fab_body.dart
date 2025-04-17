import 'package:commerce_hub/constants.dart';
import 'package:commerce_hub/models/Product.dart';
import 'package:commerce_hub/screens/product_details/components/fab.dart';
import 'package:commerce_hub/services/database/product_database_helper.dart';
import 'package:commerce_hub/size_config.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FabBody extends StatelessWidget {
  final String productId;

  const FabBody({
    Key? key,
    required this.productId,
    this.phone,
  }) : super(key: key);
  final int? phone;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(screenPadding)),
          child: FutureBuilder<Product?>(
            future: ProductDatabaseHelper().getProductWithID(productId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final product = snapshot.data;
                return Column(
                  children: [
                    AddToCartFAB(productId: productId, product: product!)
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                final error = snapshot.error.toString();
                Logger().e(error);
              }
              return Center(
                child: Icon(
                  Icons.error,
                  size: 60,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
