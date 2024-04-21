import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/Components/ui_components.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  resetPassword(String email) async {
    if (email.isEmpty) {
      return Components.customAlertBox(
        context,
        'Enter an email',
      );
    }
    FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Components.customTextField(
                  emailController,
                  "Enter email",
                  Icons.mail,
                  false,
                ),
                const SizedBox(
                  height: 15,
                ),
                Components.customButton(
                  () {
                    resetPassword(
                      emailController.text.trim(),
                    );
                  },
                  'Reset',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
