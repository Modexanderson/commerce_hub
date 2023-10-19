import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await Hive.initFlutter('Commerce Hub');
  } else {
    await Hive.initFlutter();
  }
  if (kIsWeb) {
  } else {
    // Init Your dependency
    MobileAds.instance.initialize();
  }
  await openHiveBox('settings');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(App());
}
