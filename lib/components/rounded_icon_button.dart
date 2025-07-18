// import 'package:commerce_hub/constants.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData iconData;
  final Color? color;
  final GestureTapCallback press;
  const RoundedIconButton({
    Key? key,
    required this.iconData,
    this.color,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(50),
        // ),
        // padding: EdgeInsets.zero,
        onPressed: press,
        child: Icon(
          iconData,
          color: color,
        ),
      ),
    );
  }
}
