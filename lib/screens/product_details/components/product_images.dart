import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce_hub/models/Product.dart';
import 'package:commerce_hub/screens/product_details/provider_models/ProductImageSwiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:provider/provider.dart';
// import 'package:swipedetector/swipedetector.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductImageSwiper(),
      child: Consumer<ProductImageSwiper>(
        builder: (context, productImagesSwiper, child) {
          return Column(
            children: [
              SwipeDetector(
                onSwipeLeft: (details) {
                  productImagesSwiper.currentImageIndex++;
                  productImagesSwiper.currentImageIndex %=
                      product.images!.length;
                },
                onSwipeRight: (details) {
                  productImagesSwiper.currentImageIndex--;
                  productImagesSwiper.currentImageIndex +=
                      product.images!.length;
                  productImagesSwiper.currentImageIndex %=
                      product.images!.length;
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    // color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: SizedBox(
                    height: SizeConfig.screenHeight! * 0.50,
                    width: SizeConfig.screenWidth! * 0.85,
                    child: CachedNetworkImage(
                      imageUrl: product
                          .images![productImagesSwiper.currentImageIndex],
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover, // Adjust the image's fit
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    product.images!.length,
                    (index) =>
                        buildSmallPreview(productImagesSwiper, index: index),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildSmallPreview(ProductImageSwiper productImagesSwiper,
      {required int index}) {
    return GestureDetector(
      onTap: () {
        productImagesSwiper.currentImageIndex = index;
      },
      child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8)),
          padding: EdgeInsets.all(getProportionateScreenHeight(8)),
          height: getProportionateScreenWidth(48),
          width: getProportionateScreenWidth(48),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                // color: productImagesSwiper.currentImageIndex == index
                //     ? kPrimaryColor
                //     : Colors.transparent
                ),
          ),
          child: CachedNetworkImage(
            imageUrl: product.images![index],
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.contain, // Adjust the image's fit
          )),
    );
  }
}
