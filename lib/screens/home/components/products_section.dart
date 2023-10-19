import 'package:commerce_hub/components/nothingtoshow_container.dart';
import 'package:commerce_hub/components/product_card.dart';
import 'package:commerce_hub/screens/home/components/section_tile.dart';
import 'package:commerce_hub/services/data_streams/data_stream.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:logger/logger.dart';

import '../../../size_config.dart';

class ProductsSection extends StatelessWidget {
  final String sectionTitle;
  final DataStream productsStreamController;
  final String emptyListMessage;
  final Function onProductCardTapped;
  const ProductsSection({
    Key? key,
    required this.sectionTitle,
    required this.productsStreamController,
    this.emptyListMessage = "No Products to show here",
    required this.onProductCardTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          SectionTile(
            title: sectionTitle,
            press: () {},
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          Expanded(
            child: buildProductsList(),
          ),
        ],
      ),
    );
  }

  Widget buildProductsList() {
    return StreamBuilder<dynamic>(
      stream: productsStreamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> dataList = snapshot.data;
          if (dataList.length == 0) {
            return Center(
              child: NothingToShowContainer(
                secondaryMessage: emptyListMessage,
              ),
            );
          }
          return buildProductGrid(snapshot.data);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          Logger().w(error.toString());
        }
        return Center(
          child: NothingToShowContainer(
            iconPath: "assets/icons/network_error.svg",
            primaryMessage: "Something went wrong",
            secondaryMessage: "Unable to connect to Database",
          ),
        );
      },
    );
  }

  Widget buildProductGrid(List<String> productsId) {
    return GridView.builder(
      shrinkWrap: true,
      
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 0.7,
        crossAxisSpacing: 4,
        mainAxisSpacing: 20,
      ),
      itemCount: productsId.length,
      itemBuilder: (context, index) {
        return ProductCard(
          productId: productsId[index],
          press: () {
            onProductCardTapped.call(productsId[index]);
          },
        );
      },
    );
    // StaggeredGridView.countBuilder(
    //     staggeredTileBuilder: (index) =>
    //         StaggeredTile.count(1,
    //         index.isEven ? 2 : 1.7
    //         ),
    //     mainAxisSpacing: 20,
    //     crossAxisCount: 1,
    //     // crossAxisSpacing: 4.0,
    //     itemCount: productsId.length,
    //     itemBuilder: (context, index) {
    //       return ProductCard(
    //         productId: productsId[index],
    //         press: () {
    //           onProductCardTapped.call(productsId[index]);
    //         },
    //       );
    //     });
  }
}
