import 'package:commerce_hub/constants.dart';
import 'package:commerce_hub/models/Address.dart';
import 'package:commerce_hub/services/database/user_database_helper.dart';
import 'package:commerce_hub/size_config.dart';
import 'package:flutter/material.dart';

import 'address_details_form.dart';

class Body extends StatelessWidget {
  final String? addressIdToEdit;

  const Body({Key? key, this.addressIdToEdit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(screenPadding)),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  "Fill Address Details",
                  style: headingStyle,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                addressIdToEdit == null
                    ? AddressDetailsForm(
                        addressToEdit: null,
                      )
                    : FutureBuilder<Address>(
                        future: UserDatabaseHelper()
                            .getAddressFromId(addressIdToEdit!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final address = snapshot.data;
                            return AddressDetailsForm(addressToEdit: address);
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return AddressDetailsForm(
                            addressToEdit: null,
                          );
                        },
                      ),
                SizedBox(height: getProportionateScreenHeight(40)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
