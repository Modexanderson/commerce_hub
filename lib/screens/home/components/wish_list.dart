import 'package:commerce_hub/screens/product_details/product_details_screen.dart';
import 'package:commerce_hub/services/data_streams/all_products_stream.dart';
import 'package:commerce_hub/services/data_streams/favourite_products_stream.dart';
import 'package:flutter/material.dart';

import 'products_section.dart';

class WishList extends StatefulWidget {
  const WishList({Key key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final AllProductsStream allProductsStream = AllProductsStream();

  final FavouriteProductsStream favouriteProductsStream =
      FavouriteProductsStream();

  @override
  void initState() {
    super.initState();

    favouriteProductsStream.init();
    allProductsStream.init();
  }

  @override
  void dispose() {
    favouriteProductsStream.dispose();
    allProductsStream.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: Navigator.of(context).pop,
            ),
          ),
          body: SizedBox(
            child: ProductsSection(
              sectionTitle: "Wish List",
              productsStreamController: favouriteProductsStream,
              emptyListMessage: "Add Product to Favourites",
              onProductCardTapped: onProductCardTapped,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    favouriteProductsStream.reload();
    return Future<void>.value();
  }

  void onProductCardTapped(String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          productId: productId,
          phone: null,
        ),
      ),
    ).then((_) async {
      await refreshPage();
    });
  }
}
