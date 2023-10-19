// import 'package:commerce_hub/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../theme_provider.dart';

// class ChangeThemeButtonWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return Switch.adaptive(
//       activeColor: kPrimaryColor,
//         value: themeProvider.isDarkMode,
//         onChanged: (value) {
//           final provider = Provider.of<ThemeProvider>(context, listen: false);
//           provider.toggleTheme(value);
//         });
//   }
// }
