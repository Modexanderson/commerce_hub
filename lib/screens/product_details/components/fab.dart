import 'package:commerce_hub/components/async_progress_dialog.dart';
import 'package:commerce_hub/constants.dart';
import 'package:commerce_hub/models/Product.dart';
import 'package:commerce_hub/services/authentification/authentification_service.dart';
import 'package:commerce_hub/services/database/user_database_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:logger/logger.dart';

import '../../../utils.dart';

class AddToCartFAB extends StatelessWidget {
  const AddToCartFAB({Key? key, required this.productId, required this.product})
      : super(key: key);

  final String productId;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              onPressed: () async {
                bool allowed = AuthentificationService().currentUserVerified;
                if (!allowed) {
                  final reverify = await showConfirmationDialog(context,
                      "You haven't verified your email address. This action is only allowed for verified users.",
                      positiveResponse: "Resend verification email",
                      negativeResponse: "Go back");
                  if (reverify) {
                    final future = AuthentificationService()
                        .sendVerificationEmailToCurrentUser();
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AsyncProgressDialog(
                          future,
                          message: Text("Resending verification email"),
                        );
                      },
                    );
                  }
                  return;
                }
                bool addedSuccessfully = false;
                String? snackbarMessage;
                try {
                  addedSuccessfully =
                      await UserDatabaseHelper().addProductToCart(productId);
                  if (addedSuccessfully == true) {
                    snackbarMessage = "Product added successfully";
                  } else {
                    throw "Coulnd't add product due to unknown reason";
                  }
                } on FirebaseException catch (e) {
                  Logger().w("Firebase Exception: $e");
                  snackbarMessage = "Something went wrong";
                } catch (e) {
                  Logger().w("Unknown Exception: $e");
                  snackbarMessage = "Something went wrong";
                } finally {
                  Logger().i(snackbarMessage);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(snackbarMessage!),
                    ),
                  );
                }
              },
              backgroundColor: kPrimaryColor,
              label: Text(
                "Add to Cart",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              icon: Icon(
                Icons.shopping_cart,
              ),
            ),
            SizedBox(
              height: 10,
            ),

            FloatingActionButton.extended(
              onPressed: () async {
                bool whatsapp = await FlutterLaunch.hasApp(name: 'whatsapp');
                if (whatsapp) {
                  FlutterLaunch.launchWhatsapp(
                      phone: '234' + product.phone!.substring(1),
                      message:
                          "Hello, I would like to buy your product, on Commerce hub");
                  print('Opened');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          new Text("Make sure you have whatsapp installed")));
                }
              },
              backgroundColor: kPrimaryColor,
              label: Text(
                'Contact Seller and Buy Now!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              icon: Icon(Icons.payment),
            ),
            // Container(
            //     child: FutureBuilder<Product>(
            //         future: ProductDatabaseHelper().getProductWithID(productId),
            //         builder: (context, snapshot) {
            //           if (snapshot.hasData) {

            //           } else if (snapshot.connectionState ==
            //               ConnectionState.waiting) {
            //             return Center(child: CircularProgressIndicator());
            //           } else if (snapshot.hasError) {
            //             final error = snapshot.error.toString();
            //             Logger().e(error);
            //           }
            //           return Center(
            //             child: Icon(
            //               Icons.error,
            //               color: kTextColor,
            //               size: 60,
            //             ),
            //           );
            //         }))
          ],
        ),
      ],
    );
  }
}

  // void whatsAppOpen() async {
  //   User user;
  //   bool err = false;
  //   String msgErr = '';
  //   bool whatsapp = await FlutterLaunch.hasApp(name: 'whatsapp');
  //   String uid = AuthentificationService().currentUser.uid;
  //   DocumentReference<Map<String, dynamic>> documentRef =
  //       FirebaseFirestore.instance.collection('users').doc(uid);
  //   String _phone;
  //   await documentRef.get().then((value) {
  //     _phone = value.data()['phone'].toString();
  //   });

  //   if (whatsapp) {
  //     await FlutterLaunch.launchWhatsapp(
  //         phone: '234',
  //         message: "Hello, I would like to buy your product, on Commerce hub");
  //     print('Opened');
  //   } else {
  //     err = false;
  //     msgErr = '';
  //   }
  // }