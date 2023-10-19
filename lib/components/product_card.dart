import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce_hub/services/database/product_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import 'package:commerce_hub/models/Product.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final GestureTapCallback press;
  const ProductCard({
    Key? key,
    required this.productId,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          // color: Theme.of(context).primaryColor,
          border: Border.all(
              // color: kTextColor.withOpacity(0.15)
              ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          // padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
          child: FutureBuilder<Product?>(
            future: ProductDatabaseHelper().getProductWithID(productId),
            // future: ProductDatabaseHelper().getProductWithID(productId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final Product product = snapshot.data!;
                return buildProductCardItems(product);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Center(child: CircularProgressIndicator()),
                );
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

  Column buildProductCardItems(Product product) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: CachedNetworkImage(
            imageUrl: product.images![0],
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover, // Adjust the image's fit
          ),
        ),
        SizedBox(height: 10),
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  "${product.title}\n",
                  style: TextStyle(
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 1),
              FittedBox(
                child: Text(
                  "Location: ${product.location}\n",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 0.5),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "\₦ ${product.discountPrice}\n",
                          style: TextStyle(
                            // color: kPrimaryColor,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "\₦${product.originalPrice}",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.normal,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/DiscountTag.svg",
                            // color: kPrimaryColor,
                          ),
                          Center(
                            child: Text(
                              "${product.calculatePercentageDiscount()}%\nOff",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
