import 'package:flutter/material.dart';
import 'package:flutterbase/Auth/resetpassword.dart';
import 'package:flutterbase/Auth/signuppage.dart';
import 'package:flutterbase/Components/ui_components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterbase/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, String password) async {
     if (email.isEmpty || password.isEmpty) {
      Components.customAlertBox(context, "Enter Required Fields");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
       
     on FirebaseAuthException catch (e) {
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
        title: const Text('Login Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Components.customTextField(
                emailController,
                "Email",
                Icons.mail,
                false,
              ),
              const SizedBox(
                height: 10,
              ),
              Components.customTextField(
                passwordController,
                "Password",
                Icons.password,
                true,
              ),
              const SizedBox(
                height: 10,
              ),
             Components.customButton(
                  () => login(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  ),
                  "Login",
                ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.black,
                    ),
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
                    child: const Text('Try Signing Up!'),
                  ),
                ],
              ),
              TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResetPassword(),
                        ),
                      );
                    },
                    child: const Text('Forgot Password?'),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
