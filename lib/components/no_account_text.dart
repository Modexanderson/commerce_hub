import 'package:commerce_hub/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:commerce_hub/size_config.dart';
import 'package:commerce_hub/constants.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              // color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
