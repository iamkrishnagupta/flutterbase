import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterbase/E-Auth/loginpage.dart';
import 'package:flutterbase/E-Auth/signuppage.dart';
import 'package:flutterbase/P-Auth/phoneauth.dart';


class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Verification Successful!',
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            
            const SizedBox(
              height: 10,
            ),
            TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ),
                      );
                    },
                    child: const Text('Try Phone Signup?'),
                  ),
          ],
        ),
      ),
    );
  }
}
