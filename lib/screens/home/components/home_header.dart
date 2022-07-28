import 'package:commerce_hub/components/rounded_icon_button.dart';
import 'package:commerce_hub/components/search_field.dart';
import 'package:flutter/material.dart';

import '../../../components/icon_button_with_counter.dart';

class HomeHeader extends StatelessWidget {
  final Function onSearchSubmitted;
  final Function onCartButtonPressed;
  final Function onFavouriteButtonPressed;
  const HomeHeader({
    Key key,
    @required this.onSearchSubmitted,
    @required this.onCartButtonPressed,
    @required this.onFavouriteButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RoundedIconButton(
            iconData: Icons.menu,
            press: () {
              Scaffold.of(context).openDrawer();
            }),
        Expanded(
          child: SearchField(
            onSubmit: onSearchSubmitted,
          ),
        ),
        SizedBox(width: 5),
        IconButtonWithCounter(
          svgSrc: "assets/icons/Cart Icon.svg",
          numOfItems: 0,
          press: onCartButtonPressed,
        ),
        SizedBox(width: 5),
        IconButton(
          onPressed: onFavouriteButtonPressed,
          icon: Icon(
            Icons.favorite_border_sharp,
          ),
          // press: ,
          // svgSrc: "assets/icons/Cart Icon.svg",
          // numOfItems: 0,
        ),
      ],
    );
  }
}
