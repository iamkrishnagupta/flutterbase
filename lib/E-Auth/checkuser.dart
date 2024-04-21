import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/E-Auth/loginpage.dart';
import 'package:flutterbase/homepage.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return checkUser();
  }

  Widget checkUser() {
    return FirebaseAuth.instance.currentUser != null
        ? const HomePage() 
        : const LoginPage(); 
  }
}
