import 'package:commerce_hub/components/rounded_icon_button.dart';
import 'package:commerce_hub/components/search_field.dart';
import 'package:commerce_hub/constants.dart';
import 'package:flutter/material.dart';

import '../../../components/icon_button_with_counter.dart';

class HomeHeader extends StatelessWidget {
  final Function onSearchSubmitted;
  final Function onCartButtonPressed;
  final Function onFavouriteButtonPressed;
  const HomeHeader({
    Key? key,
    required this.onSearchSubmitted,
    required this.onCartButtonPressed,
    required this.onFavouriteButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RoundedIconButton(
            iconData: Icons.menu,
            // color: Colors.grey[700],
            press: () {
              Scaffold.of(context).openDrawer();
            }),
        Expanded(
          child: SearchField(
            onSubmit: () {
              onSearchSubmitted();
            },
          ),
        ),
        SizedBox(width: 5),
        IconButtonWithCounter(
            // svgSrc: "assets/icons/Cart Icon.svg",
            icon: Icon(Icons.shopping_cart_outlined),
            numOfItems: 0,
            press: () {
              onCartButtonPressed();
            }),
        SizedBox(width: 5),
        IconButtonWithCounter(
            // svgSrc: Icons.favorite_border_sharp.toString(),
            icon: Icon(
              Icons.favorite_border_sharp,
              // color: Colors.grey[700],
            ),
            numOfItems: 0,
            press: () {
              onFavouriteButtonPressed();
            }),

        // IconButton(
        //   onPressed: onFavouriteButtonPressed,
        //   icon: Icon(
        //     Icons.favorite_border_sharp,
        //     color: Colors.grey[700],
        //   ),
        // press: ,
        // svgSrc: "assets/icons/Cart Icon.svg",
        // numOfItems: 0,
        // ),
      ],
    );
  }
}
