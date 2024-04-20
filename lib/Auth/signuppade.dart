import 'package:flutter/material.dart';
import 'package:flutterbase/Auth/loginpage.dart';
import 'package:flutterbase/Components/ui_components.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Components.customTextField(
                nameController,
                "Name",
                Icons.person,
                false,
              ),
              const SizedBox(
                height: 10,
              ),
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
                () {
                  // Implement signup functionality here
                },
                "Signup",
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
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
    );
  }
}
