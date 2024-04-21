import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/P-Auth/otppage.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phone Auth',
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: phoneController,
              // keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter Phone Number",
                suffix: const Icon(
                  Icons.phone,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                verificationCompleted: (
                  PhoneAuthCredential credential,
                ) {},
                verificationFailed: (
                  FirebaseAuthException e,
                ) {},
                codeSent: (
                  String verificationId,
                  int? resendingToken,
                ) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OTPPage(
                        verificationID: verificationId,
                      ),
                    ),
                  );
                },
                codeAutoRetrievalTimeout: (
                  String verificationId,
                ) {},
                phoneNumber: phoneController.text.trim(),
              );
            },
            child: const Text(
              'Verify Phone',
            ),
          )
        ],
      ),
    );
  }
}
