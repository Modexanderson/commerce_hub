import 'package:flutter/material.dart';

import 'components/body.dart';

class EditAddressScreen extends StatelessWidget {
  final String? addressIdToEdit;

  const EditAddressScreen({Key? key, this.addressIdToEdit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: Body(addressIdToEdit: addressIdToEdit),
    );
  }
}
