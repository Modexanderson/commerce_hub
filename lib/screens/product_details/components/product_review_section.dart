import 'package:commerce_hub/components/top_rounded_container.dart';
import 'package:commerce_hub/models/Product.dart';
import 'package:commerce_hub/models/Review.dart';
import 'package:commerce_hub/services/database/product_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'review_box.dart';

class ProductReviewsSection extends StatelessWidget {
  const ProductReviewsSection({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(320),
      child: Stack(
        children: [
          TopRoundedContainer(
            // color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                Text(
                  "Product Reviews",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Expanded(
                  child: StreamBuilder<List<Review>>(
                    stream: ProductDatabaseHelper()
                        .getAllReviewsStreamForProductId(product.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final reviewsList = snapshot.data;
                        if (reviewsList!.length == 0) {
                          return Center(
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/review.svg",
                                  // color: kTextColor,
                                  width: 40,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "No reviews yet",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: reviewsList.length,
                          itemBuilder: (context, index) {
                            return ReviewBox(
                              review: reviewsList[index],
                            );
                          },
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        final error = snapshot.error;
                        Logger().w(error.toString());
                      }
                      return Center(
                        child: Icon(
                          Icons.error,
                          size: 50,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: buildProductRatingWidget(product.rating!),
          ),
        ],
      ),
    );
  }

  Widget buildProductRatingWidget(num rating) {
    return Container(
      width: getProportionateScreenWidth(80),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "$rating",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: getProportionateScreenWidth(16),
              ),
            ),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.star,
          ),
        ],
      ),
    );
  }
}
