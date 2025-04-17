import 'package:commerce_hub/constants.dart';
import 'package:commerce_hub/models/Product.dart';
import 'package:commerce_hub/screens/product_details/components/product_actions_section.dart';
import 'package:commerce_hub/screens/product_details/components/product_images.dart';
import 'package:commerce_hub/services/database/product_database_helper.dart';
import 'package:commerce_hub/size_config.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'product_review_section.dart';
import 'package:commerce_hub/models/Ads.dart';

class Body extends StatelessWidget {
  final String productId;

  const Body({
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
                    ProductImages(product: product!),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    ProductActionsSection(product: product),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    ProductReviewsSection(product: product),
                    SizedBox(height: getProportionateScreenHeight(100)),
                    Ads(),
                    SizedBox(
                      height: 200,
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                        // color: kPrimaryColor,
                        ));
              } else if (snapshot.hasError) {
                final error = snapshot.error.toString();
                Logger().e(error);
              }
              return Center(
                child: Icon(
                  Icons.error,
                  // color: kTextColor,
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
