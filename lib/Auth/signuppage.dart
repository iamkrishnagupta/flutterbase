import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterbase/Components/ui_components.dart';
import 'package:flutterbase/homepage.dart';
import 'package:flutterbase/Auth/loginpage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Components.customAlertBox(context, "Enter Required Fields");
    } else {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Assuming you want to navigate the user to HomePage after signing up
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        // Detailed error handling
        Components.customAlertBox(
            context, e.message ?? "An unknown error occurred with Firebase.");
      } catch (e) {
        // General error handling
        Components.customAlertBox(
            context, "An error occurred. Please try again.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: SingleChildScrollView(
            // Added SingleChildScrollView for better usability
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Components.customTextField(
                  nameController,
                  "Name",
                  Icons.person,
                  false,
                ),
                const SizedBox(height: 10),
                Components.customTextField(
                  emailController,
                  "Email",
                  Icons.mail,
                  false,
                ),
                const SizedBox(height: 10),
                Components.customTextField(
                  passwordController,
                  "Password",
                  Icons.lock,
                  true,
                ),
                const SizedBox(height: 20),
                Components.customButton(
                  () => signUp(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  ),
                  "Signup",
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text('Try Login!'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
