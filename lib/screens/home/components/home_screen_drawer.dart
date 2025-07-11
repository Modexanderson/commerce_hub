import 'package:commerce_hub/components/async_progress_dialog.dart';
import 'package:commerce_hub/constants.dart';
import 'package:commerce_hub/screens/change_display_picture/change_display_picture_screen.dart';
import 'package:commerce_hub/screens/change_email/change_email_screen.dart';
import 'package:commerce_hub/screens/change_password/change_password_screen.dart';
import 'package:commerce_hub/screens/change_phone/change_phone_screen.dart';
import 'package:commerce_hub/screens/edit_product/edit_product_screen.dart';
import 'package:commerce_hub/screens/my_products/my_products_screen.dart';
import 'package:commerce_hub/screens/settings/settings_screen.dart';
import 'package:commerce_hub/services/authentification/authentification_service.dart';
import 'package:commerce_hub/services/database/user_database_helper.dart';
import 'package:commerce_hub/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../change_display_name/change_display_name_screen.dart';

class HomeScreenDrawer extends StatefulWidget {
  const HomeScreenDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  final _emailAddress =
      'mailto:mordecaizakwoyi@gmail.com?subject=Bug Report&body=Hello,';
  final _appLink =
      'https://play.google.com/store/apps/details?id=com.commerce.hub';
  void _shareApp() {
    Share.share(_appLink);
  }

  void _openEmail() async {
    if (await UrlLauncher.canLaunch(_emailAddress)) {
      UrlLauncher.launch(_emailAddress);
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          StreamBuilder<User?>(
              stream: AuthentificationService().userChanges,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final user = snapshot.data;
                  return buildUserAccountsHeader(user!);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    child: Icon(Icons.error),
                  );
                }
              }),
          Expanded(
            child: ListView(
              children: [
                buildEditAccountExpansionTile(context),
                // ListTile(
                //   leading: Icon(
                //     Icons.edit_location,
                //   ),
                //   title: Text(
                //     "Manage Addresses",
                //     style: TextStyle(fontSize: 16, color: Colors.black),
                //   ),
                //   onTap: () async {
                //     bool allowed = AuthentificationService().currentUserVerified;
                //     if (!allowed) {
                //       final reverify = await showConfirmationDialog(context,
                //           "You haven't verified your email address. This action is only allowed for verified users.",
                //           positiveResponse: "Resend verification email",
                //           negativeResponse: "Go back");
                //       if (reverify) {
                //         final future = AuthentificationService()
                //             .sendVerificationEmailToCurrentUser();
                //         await showDialog(
                //           context: context,
                //           builder: (context) {
                //             return AsyncProgressDialog(
                //               future,
                //               message: Text("Resending verification email"),
                //             );
                //           },
                //         );
                //       }
                //       return;
                //     }
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ManageAddressesScreen(),
                //       ),
                //     );
                //   },
                // ),
                // ListTile(
                //   leading: Icon(Icons.edit_location),
                //   title: Text(
                //     "My Orders",
                //     style: TextStyle(fontSize: 16, color: Colors.black),
                //   ),
                //   onTap: () async {
                //     bool allowed = AuthentificationService().currentUserVerified;
                //     if (!allowed) {
                //       final reverify = await showConfirmationDialog(context,
                //           "You haven't verified your email address. This action is only allowed for verified users.",
                //           positiveResponse: "Resend verification email",
                //           negativeResponse: "Go back");
                //       if (reverify) {
                //         final future = AuthentificationService()
                //             .sendVerificationEmailToCurrentUser();
                //         await showDialog(
                //           context: context,
                //           builder: (context) {
                //             return AsyncProgressDialog(
                //               future,
                //               message: Text("Resending verification email"),
                //             );
                //           },
                //         );
                //       }
                //       return;
                //     }
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => MyOrdersScreen(),
                //       ),
                //     );
                //   },
                // ),
                buildSellerExpansionTile(context),

                ListTile(
                  leading: Icon(
                    Icons.share,
                  ),
                  title: Text(
                    "Share App",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: _shareApp,
                ),

                ListTile(
                  leading: Icon(
                    Icons.settings,
                  ),
                  title: Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(),
                      ),
                    );
                  },
                ),

                ListTile(
                  leading: Icon(
                    Icons.logout,
                  ),
                  title: Text(
                    "Sign out",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () async {
                    final confirmation = await showConfirmationDialog(
                        context, "Confirm Sign out ?");
                    if (confirmation) AuthentificationService().signOut();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  UserAccountsDrawerHeader buildUserAccountsHeader(User user) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(),
      margin: EdgeInsets.zero,
      accountEmail: Text(
        user.email ?? "No Email",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      accountName: Text(
        user.displayName ?? "No Name",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      currentAccountPicture: FutureBuilder(
        future: UserDatabaseHelper().displayPictureForCurrentUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            if (error != null) {
              final errorMessage = error; // Explicitly cast to String
              Logger().w(errorMessage);
            }
          }
          return CircleAvatar(
              // backgroundColor: kTextColor,
              );
        },
      ),
    );
  }

  ExpansionTile buildEditAccountExpansionTile(BuildContext context) {
    return ExpansionTile(
      // iconColor: kPrimaryColor,
      // textColor: kPrimaryColor,
      leading: Icon(
        Icons.person,
      ),
      title: Text(
        "Edit Account",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      children: [
        ListTile(
          title: Text(
            "Change Display Picture",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeDisplayPictureScreen(),
                ));
          },
        ),
        ListTile(
          title: Text(
            "Change Display Name",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeDisplayNameScreen(),
                ));
          },
        ),
        ListTile(
          title: Text(
            "Change Phone Number",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePhoneScreen(),
                ));
          },
        ),
        ListTile(
          title: Text(
            "Change Email",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeEmailScreen(),
                ));
          },
        ),
        ListTile(
          title: Text(
            "Change Password",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePasswordScreen(),
                ));
          },
        ),
      ],
    );
  }

  Widget buildSellerExpansionTile(BuildContext context) {
    return ExpansionTile(
      // iconColor: kPrimaryColor,
      // textColor: kPrimaryColor,
      leading: Icon(
        Icons.business,
      ),
      title: Text(
        "I am a Seller",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      children: [
        ListTile(
          title: Text(
            "Add New Product",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onTap: () async {
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProductScreen(
                          productToEdit: null,
                        )));
          },
        ),
        ListTile(
          title: Text(
            "Manage My Products",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onTap: () async {
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyProductsScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
