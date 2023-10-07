import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:i_called/app/app.dart';
import 'package:i_called/app/locator.dart';
import 'package:i_called/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SetUpLocators.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}
