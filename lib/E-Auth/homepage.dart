import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterbase/C-Storage/demopage.dart';
import 'package:flutterbase/E-Auth/loginpage.dart';
import 'package:flutterbase/F-Store/fetchdata.dart';
import 'package:flutterbase/P-Auth/phoneauth.dart';
import 'package:flutterbase/S-Data/senddata.dart';

import 'signuppage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  logOut(BuildContext context) async {
    FirebaseAuth.instance.signOut().then(
          (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Home Page!',
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => logOut(context),
                  ),
                );
              },
              child: const Text('Log Out!'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PhoneAuth(),
                  ),
                );
              },
              child: const Text('Try Phone Verification?'),
            ),
            
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FetchData(),
                  ),
                );
              },
              child: const Text(
                'Try Firestore?',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DemoPage(),
                  ),
                );
              },
              child: const Text(
                'Try Cloud Storage?',
              ),
            ), 
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SendData(),
                  ),
                );
              },
              child: const Text(
                'Try Sending Data?',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
