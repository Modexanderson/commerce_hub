import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../size_config.dart';

class IconButtonWithCounter extends StatelessWidget {
  final String? svgSrc;
  final Icon? icon;
  final int numOfItems;
  final GestureTapCallback press;
  const IconButtonWithCounter({
    Key? key,
    this.svgSrc,
    this.icon,
    this.numOfItems = 0,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        clipBehavior:
            Clip.none, // makes the stack clip over the overlapping widget
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            width: getProportionateScreenWidth(46),
            height: getProportionateScreenWidth(46),
            decoration: BoxDecoration(
              // color: kSecondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: svgSrc != null ? SvgPicture.asset(svgSrc!) : icon,
          ),
          if (numOfItems > 0)
            Positioned(
              right: 0,
              top: -3,
              child: Container(
                width: getProportionateScreenWidth(20),
                height: getProportionateScreenWidth(20),
                decoration: BoxDecoration(
                  // color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "$numOfItems",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      // color: Colors.white,
                      height: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
