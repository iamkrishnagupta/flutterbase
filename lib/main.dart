import 'package:flutter/material.dart';
import 'package:flutterbase/E-Auth/loginpage.dart';
import 'package:flutterbase/E-Auth/checkuser.dart';
import 'package:flutterbase/F-Message/notificationservices.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationServices.initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CheckUser(),
    );
  }
}
